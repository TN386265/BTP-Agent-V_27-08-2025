CLASS /zuora001/cl_analytics_m DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES:
      BEGIN OF ty_cust_fiscal_periods,
        CustomerId   TYPE /zuora001/decustomerid,
        FiscYear     TYPE /zuora001/defisc_year,
        FisPeriod    TYPE /zuora001/defisc_period,
        CustomerName TYPE /zuora001/decust_name,
      END OF ty_cust_fiscal_periods.

    TYPES:
             tt_cust_fiscal_periods TYPE STANDARD TABLE OF ty_cust_fiscal_periods.


    TYPES:
      BEGIN OF ty_cust_data,
        CustomerId   TYPE /zuora001/decustomerid,
        CustomerName TYPE /zuora001/decust_name,
      END OF ty_cust_data.

    TYPES:
        tt_cust_data TYPE STANDARD TABLE OF ty_cust_data.

    TYPES:
      BEGIN OF ty_capbm_data,
        CapabilityId   TYPE /zuora001/decapbid,
        CapabilityName TYPE /zuora001/decapb_name,
      END OF ty_capbm_data.

    TYPES:
        tt_capbm_data TYPE STANDARD TABLE OF ty_capbm_data.

    CLASS-METHODS:

      cust_fiscal_periods
        AMDP OPTIONS READ-ONLY
        CDS SESSION CLIENT DEPENDENT
        IMPORTING
          VALUE(p_year)                 TYPE /zuora001/defisc_year
          VALUE(p_fperiod)              TYPE /zuora001/defisc_period
          VALUE(p_tperiod)              TYPE /zuora001/defisc_period
        EXPORTING
          VALUE(et_cust_fiscal_periods) TYPE tt_cust_fiscal_periods,


      str_to_table_custids AMDP OPTIONS READ-ONLY
        CDS SESSION CLIENT DEPENDENT
        IMPORTING
          VALUE(p_customer_id) TYPE /zuora001/delongchar
        EXPORTING
          VALUE(et_cust_data)  TYPE tt_cust_data,

      str_to_table_capbids AMDP OPTIONS READ-ONLY
        CDS SESSION CLIENT DEPENDENT
        IMPORTING
          VALUE(p_capability_id) TYPE /zuora001/delongchar
        EXPORTING
          VALUE(et_capbm_data)   TYPE tt_capbm_data,

      get_cust_apia FOR TABLE FUNCTION /zuora001/tf_cstapica,
      get_cust_apicapb FOR TABLE FUNCTION /zuora001/tf_cstapicb,

* For customer specific API Analytics - used in customer-specific(RLS) oData
      get_cust_apicapd FOR TABLE FUNCTION /zuora001/tf_cstapid,
* The function-get_cust_apicapdV4 logic is same as get_cust_apicapd. Added to handle the length issue of destination system-from 10 to 30
      get_cust_apicapdV4 FOR TABLE FUNCTION /zuora001/tf_cstapidv4,

      get_cust_apicapdv2 FOR TABLE FUNCTION /zuora001/tf_cstapidv2,
* The function-get_cust_apicapdv2v4 logic is same as get_cust_apicapdv2. Added to handle the length issue of destination system-from 10 to 30
      get_cust_apicapdv2v4 FOR TABLE FUNCTION /zuora001/tf_cstapidv2v4,

      get_valid_cpbt FOR TABLE FUNCTION /zuora001/tf_cpbtv,

      get_cust_list FOR TABLE FUNCTION /zuora001/tf_cstlist.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/CL_ANALYTICS_M IMPLEMENTATION.


  METHOD cust_fiscal_periods BY DATABASE PROCEDURE FOR HDB
    LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING /zuora001/i_je_h /zuora001/i_custa.
    IF p_year = 0 then
        lt_fiscal_year = SELECT CustomerId, MAX(FiscYear) AS FiscYear, 0 AS FisPeriod
                         FROM "/ZUORA001/I_JE_H"
                         group BY CustomerId;

        et_cust_fiscal_periods = SELECT h.CustomerId, f.FiscYear, max(h.FisPeriod) AS FisPeriod, MAX(c.CustomerName) AS CustomerName
                     FROM "/ZUORA001/I_JE_H" AS h
                     INNER JOIN :lt_fiscal_year AS f ON f.CustomerId = h.CustomerId and f.FiscYear = h.FiscYear
                     inner join "/ZUORA001/I_CUSTA" AS c ON c.CustomerId = h.CustomerId AND c.Status = '1'
                     group by h.CustomerId, f.FiscYear;
    else
        lt_fiscal_year = select CustomerId, FiscYear, FisPeriod from "/ZUORA001/I_JE_H"
                         where FiscYear = :p_year and fisperiod >= :p_fperiod AND fisperiod <= :p_tperiod
                         GROUP BY CustomerId, FiscYear, FisPeriod;

        et_cust_fiscal_periods = select h.CustomerId, f.FiscYear, h.FisPeriod, max(c.CustomerName) AS CustomerName
                     FROM "/ZUORA001/I_JE_H" AS h
                     INNER JOIN :lt_fiscal_year AS f ON f.CustomerId = h.CustomerId and f.FiscYear = h.FiscYear and f.FisPeriod = h.fisperiod
                     inner join "/ZUORA001/I_CUSTA" AS c ON c.CustomerId = h.CustomerId AND c.Status = '1'
                     group by h.CustomerId, f.FiscYear, h.FisPeriod;
    end if;
  ENDMETHOD.


  METHOD get_cust_apia BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_apica /zuora001/i_custa /zuora001/cl_analytics_m=>str_to_table_custids /zuora001/cl_analytics_m=>str_to_table_capbids.

    IF p_customer_id = '*' THEN
        lt_cust_data = SELECT c.CustomerId,c.CustomerName from "/ZUORA001/I_CUSTA" AS c WHERE c.Status = '1';
    else
        call "/ZUORA001/CL_ANALYTICS_M=>STR_TO_TABLE_CUSTIDS"(p_customer_id=>:p_customer_id, et_cust_data=>lt_cust_data);
    end if;

    if p_capability_id = '*' then

        lt_final =
            select c.CustomerId, max(lcd.CustomerName) as CustomerName,
                   sum( case WHEN c.status = 'S' THEN 1 ELSE 0 END ) AS SuccessCalls,
                   sum( case WHEN c.status = 'E' THEN 1 ELSE 0 END ) AS FailureCalls
            from "/ZUORA001/I_APICA" AS c
            INNER JOIN :lt_cust_data AS lcd ON lcd.CustomerId = c.CustomerId
            where cast( cast(c.apistartdate as timestamp) AS date) BETWEEN :p_from_date AND :p_to_date
            group by c.CustomerId;

    else

        call "/ZUORA001/CL_ANALYTICS_M=>STR_TO_TABLE_CAPBIDS"(p_capability_id=>:p_capability_id, et_capbm_data=>lt_capbm_data);

        lt_final =
            select c.CustomerId, max(lcd.CustomerName) as CustomerName,
                   sum( case WHEN c.status = 'S' THEN 1 ELSE 0 END ) AS SuccessCalls,
                   sum( case WHEN c.status = 'E' THEN 1 ELSE 0 END ) AS FailureCalls
            from "/ZUORA001/I_APICA" AS c
            INNER JOIN :lt_cust_data AS lcd ON lcd.CustomerId = c.CustomerId
            inner join :lt_capbm_data as lcmd on lcmd.CapabilityId = c.CapabilityId
            where cast( cast(c.apistartdate as timestamp) AS date) BETWEEN :p_from_date AND :p_to_date
            group by c.CustomerId;

    end if;


    return
        select session_context('CDS_CLIENT') as Client, CustomerId, CustomerName, null as FiscYear, null as FisPeriod,
               SuccessCalls, FailureCalls
        from :lt_final;

  endmethod.


  METHOD get_cust_apicapb BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_apica /zuora001/i_custa /zuora001/i_cpbta /zuora001/cl_analytics_m=>str_to_table_custids.

    IF p_customer_id = '*' THEN
        lt_cust_data = SELECT c.CustomerId,c.CustomerName from "/ZUORA001/I_CUSTA" AS c WHERE c.Status = '1';
    else
        call "/ZUORA001/CL_ANALYTICS_M=>STR_TO_TABLE_CUSTIDS"(p_customer_id=>:p_customer_id, et_cust_data=>lt_cust_data);
    end if;

    if :p_capbwise = 'Y' then
        lt_final =
        select c.CustomerId, max(lcd.CustomerName) AS CustomerName,
               c.CapabilityId, max(cpb.CapabilityName) AS CapabilityName,
               NULL AS FiscYear, NULL AS FisPeriod,
               sum( case WHEN c.status = 'S' THEN 1 ELSE 0 END ) AS SuccessCalls,
               sum( case WHEN c.status = 'E' THEN 1 ELSE 0 END ) AS FailureCalls
        from "/ZUORA001/I_APICA" AS c
        left outer join "/ZUORA001/I_CPBTA" AS cpb ON cpb.CapabilityId = c.CapabilityId AND cpb.status = '1'
        inner join :lt_cust_data as lcd ON lcd.CustomerId = c.CustomerId
        where cast( cast(c.apistartdate as timestamp) AS date) BETWEEN :p_from_date AND :p_to_date
        group by c.CustomerId, c.CapabilityId;
    else
        lt_final =
        select c.CustomerId, max(lcd.CustomerName) AS CustomerName,
               0 AS CapabilityId, NULL AS CapabilityName,
               NULL AS FiscYear, NULL AS FisPeriod,
               sum( case WHEN c.status = 'S' THEN 1 ELSE 0 END ) AS SuccessCalls,
               sum( case WHEN c.status = 'E' THEN 1 ELSE 0 END ) AS FailureCalls
        from "/ZUORA001/I_APICA" AS c
        inner join :lt_cust_data as lcd ON lcd.CustomerId = c.CustomerId
        where cast( cast(c.apistartdate as timestamp) AS date) BETWEEN :p_from_date AND :p_to_date
        group by c.CustomerId;
     end if;

    return
    select session_context('CDS_CLIENT') as Client, CustomerId, CustomerName,
           CapabilityId, CapabilityName,
           FiscYear, FisPeriod,
           SuccessCalls, FailureCalls, SuccessCalls + FailureCalls as TotalCalls,
           round(( ( SuccessCalls / ( SuccessCalls + FailureCalls ) ) * 100 ),2) as SuccessRate,
           ROUND(( ( FailureCalls / ( SuccessCalls + FailureCalls ) ) * 100 ),2) as FailureRate
    from :lt_final;


  ENDMETHOD.


  METHOD get_cust_apicapd BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_apica /zuora001/i_custa /zuora001/i_cpbta /zuora001/cl_analytics_m=>str_to_table_custids.

    IF p_customer_id = '*' THEN
        lt_cust_data = SELECT c.CustomerId,c.CustomerName from "/ZUORA001/I_CUSTA" AS c WHERE c.Status = '1';
    else
        call "/ZUORA001/CL_ANALYTICS_M=>STR_TO_TABLE_CUSTIDS"(p_customer_id=>:p_customer_id, et_cust_data=>lt_cust_data);
    end if;


    return
        select session_context('CDS_CLIENT') as Client, c.CustomerId, max(lcd.CustomerName) AS CustomerName,
               c.CapabilityId, max(cpb.CapabilityName) AS CapabilityName,
               cast(c.DsetinationSystem as nvarchar( 10 )) as DestinationSystem, c.DestinationName,
               null as FiscYear, null as FisPeriod,
               sum( case when c.status = 'S' THEN 1 ELSE 0 END ) AS SuccessCalls,
               sum( case WHEN c.status = 'E' THEN 1 ELSE 0 END ) AS FailureCalls
        from "/ZUORA001/I_APICA" AS c
        INNER JOIN :lt_cust_data AS lcd ON lcd.CustomerId = c.CustomerId
        left outer join "/ZUORA001/I_CPBTA" AS cpb ON cpb.CapabilityId = c.CapabilityId AND cpb.status = '1'
        where cast( cast(c.apistartdate as timestamp) AS date) BETWEEN :p_from_date AND :p_to_date
        group by c.CustomerId, c.CapabilityId, c.DsetinationSystem, c.DestinationName;


  endmethod.


  METHOD get_cust_apicapdv2 BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_apica /zuora001/i_custa /zuora001/i_cpbta.

    RETURN
        select session_context('CDS_CLIENT') as Client, c.CustomerId, max(lcd.CustomerName) AS CustomerName,
               c.CapabilityId, max(cpb.CapabilityName) AS CapabilityName,
               cast(c.DsetinationSystem as nvarchar( 10 )) as DestinationSystem, c.DestinationName,
               null as FiscYear, null as FisPeriod,
               sum( case when c.status = 'S' THEN 1 ELSE 0 END ) AS SuccessCalls,
               sum( case WHEN c.status = 'E' THEN 1 ELSE 0 END ) AS FailureCalls
        from "/ZUORA001/I_APICA" AS c
        INNER JOIN "/ZUORA001/I_CUSTA" AS lcd ON lcd.CustomerId = c.CustomerId AND lcd.status = '1'
        left outer join "/ZUORA001/I_CPBTA" AS cpb ON cpb.CapabilityId = c.CapabilityId AND cpb.status = '1'
        WHERE cast( cast(c.apistartdate as timestamp) AS date) BETWEEN :p_from_date AND :p_to_date
        group by c.CustomerId, c.CapabilityId, c.DsetinationSystem, c.DestinationName;

  endmethod.


  METHOD get_cust_apicapdv2v4 BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_apica /zuora001/i_custa /zuora001/i_cpbta.

    RETURN
        select session_context('CDS_CLIENT') as Client, c.CustomerId, max(lcd.CustomerName) AS CustomerName,
               c.CapabilityId, max(cpb.CapabilityName) AS CapabilityName,
               c.DsetinationSystem as DestinationSystem, c.DestinationName,
               null as FiscYear, null as FisPeriod,
               sum( case when c.status = 'S' THEN 1 ELSE 0 END ) AS SuccessCalls,
               sum( case WHEN c.status = 'E' THEN 1 ELSE 0 END ) AS FailureCalls
        from "/ZUORA001/I_APICA" AS c
        INNER JOIN "/ZUORA001/I_CUSTA" AS lcd ON lcd.CustomerId = c.CustomerId AND lcd.status = '1'
        left outer join "/ZUORA001/I_CPBTA" AS cpb ON cpb.CapabilityId = c.CapabilityId AND cpb.status = '1'
        WHERE cast( cast(c.apistartdate as timestamp) AS date) BETWEEN :p_from_date AND :p_to_date
        group by c.CustomerId, c.CapabilityId, c.DsetinationSystem, c.DestinationName;

  endmethod.


  METHOD get_cust_apicapdV4 BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_apica /zuora001/i_custa /zuora001/i_cpbta /zuora001/cl_analytics_m=>str_to_table_custids.

    IF p_customer_id = '*' THEN
        lt_cust_data = SELECT c.CustomerId,c.CustomerName from "/ZUORA001/I_CUSTA" AS c WHERE c.Status = '1';
    else
        call "/ZUORA001/CL_ANALYTICS_M=>STR_TO_TABLE_CUSTIDS"(p_customer_id=>:p_customer_id, et_cust_data=>lt_cust_data);
    end if;


    return
        select session_context('CDS_CLIENT') as Client, c.CustomerId, max(lcd.CustomerName) AS CustomerName,
               c.CapabilityId, max(cpb.CapabilityName) AS CapabilityName,
               c.DsetinationSystem as DestinationSystem, c.DestinationName,
               null as FiscYear, null as FisPeriod,
               sum( case when c.status = 'S' THEN 1 ELSE 0 END ) AS SuccessCalls,
               sum( case WHEN c.status = 'E' THEN 1 ELSE 0 END ) AS FailureCalls
        from "/ZUORA001/I_APICA" AS c
        INNER JOIN :lt_cust_data AS lcd ON lcd.CustomerId = c.CustomerId
        left outer join "/ZUORA001/I_CPBTA" AS cpb ON cpb.CapabilityId = c.CapabilityId AND cpb.status = '1'
        where cast( cast(c.apistartdate as timestamp) AS date) BETWEEN :p_from_date AND :p_to_date
        group by c.CustomerId, c.CapabilityId, c.DsetinationSystem, c.DestinationName;


  endmethod.


  METHOD get_cust_list BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/I_CUSTA /ZUORA001/I_CUSTCAPBR /zuora001/cl_analytics_m=>str_to_table_capbids.

    IF p_capability_id = '*' THEN
        RETURN
          select session_context('CDS_CLIENT') as Client, CustomerId, ValidFrom, ValidTo, CustomerName,
                 ActivatedDate, ExpiryDate, Active, Status, CreatedBy, CreatedAt, LocalChangedBy,
                 LocalLastChangedAt, LastChangedAt
          FROM "/ZUORA001/I_CUSTA";

    ELSE

        CALL "/ZUORA001/CL_ANALYTICS_M=>STR_TO_TABLE_CAPBIDS"(p_capability_id=>:p_capability_id, et_capbm_data=>lt_capbm_data);

        lt_cust_capb =
            SELECT cr.CustomerId
            FROM "/ZUORA001/I_CUSTCAPBR" AS cr
            INNER JOIN :lt_capbm_data AS lcmd ON lcmd.CapabilityId = cr.CapabilityId
            WHERE cr.Status = '1' AND cr.Active = '1'
            GROUP BY cr.CustomerId;

        return
          SELECT session_context('CDS_CLIENT') AS Client, c.CustomerId, c.ValidFrom, c.ValidTo, c.CustomerName,
                 c.ActivatedDate, c.ExpiryDate, c.Active, c.Status, c.CreatedBy, c.CreatedAt, c.LocalChangedBy,
                 c.LocalLastChangedAt, c.LastChangedAt
          FROM "/ZUORA001/I_CUSTA" AS c
          INNER JOIN :lt_cust_capb AS lcc ON lcc.CustomerId = c.CustomerId ;

    end if;

  ENDMETHOD.


  METHOD get_valid_cpbt BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_cpbta.

    lt_base = select CapabilityId, MAX( ValidFrom ) AS ValidFrom
              FROM "/ZUORA001/I_CPBTA"
              WHERE Status = '1'
              GROUP BY CapabilityId;

    RETURN
        select session_context('CDS_CLIENT') as Client, ta.CapabilityId, ta.ValidFrom, ta.ValidTo,
               ta.CapabilityName, ta.Status, ta.CreatedBy, ta.CreatedAt, ta.LocalChangedBy,
               ta.LocalLastChangedAt, ta.LastChangedAt
        from "/ZUORA001/I_CPBTA" AS ta
        inner join :lt_base as b on b.CapabilityId = ta.CapabilityId and b.ValidFrom = ta.ValidFrom
        where ta.Status = '1';

  ENDMETHOD.


  METHOD str_to_table_capbids BY DATABASE PROCEDURE FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_cpbt.

    DECLARE lids NVARCHAR(4000) := :p_capability_id || ',';
    DECLARE lids_iterate NVARCHAR(4000);

    lt_split_ids = SELECT SUBSTR_BEFORE(:lids,',') AS SINGLE_VAL FROM DUMMY;

    SELECT SUBSTR_AFTER(:lids,',') || ',' INTO lids_iterate FROM DUMMY;

    WHILE LENGTH(:lids_iterate) > 0
    DO
        lt_split_ids = SELECT SINGLE_VAL FROM :lt_split_ids
                       UNION
                       SELECT SUBSTR_BEFORE(:lids_iterate,',') AS SINGLE_VAL FROM DUMMY;

        SELECT SUBSTR_AFTER(:lids_iterate,',') INTO lids_iterate FROM DUMMY;
    END WHILE;

    lt_split_ids = SELECT CAST(SINGLE_VAL AS INTEGER) AS SINGLE_VAL FROM :lt_split_ids WHERE SINGLE_VAL IS NOT NULL AND LENGTH(IFNULL(SINGLE_VAL,'')) > 0;

    et_capbm_data = SELECT c.CapabilityId, c.CapabilityName
                   FROM :lt_split_ids AS lsi
                   INNER JOIN "/ZUORA001/I_CPBT" AS c ON c.CapabilityId = lsi.SINGLE_VAL AND c.Status = '1';

  ENDMETHOD.


  METHOD str_to_table_custids BY DATABASE PROCEDURE FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_custa.

    DECLARE custids NVARCHAR(4000) := :p_customer_id || ',';
    DECLARE custids_iterate NVARCHAR(4000);

    lt_split_ids = SELECT SUBSTR_BEFORE(:custids,',') AS SINGLE_VAL FROM DUMMY;

    SELECT SUBSTR_AFTER(:custids,',') || ',' INTO custids_iterate FROM DUMMY;

    WHILE LENGTH(:custids_iterate) > 0
    DO
        lt_split_ids = SELECT SINGLE_VAL FROM :lt_split_ids
                       UNION
                       SELECT SUBSTR_BEFORE(:custids_iterate,',') AS SINGLE_VAL FROM DUMMY;

        SELECT SUBSTR_AFTER(:custids_iterate,',') INTO custids_iterate FROM DUMMY;
    END WHILE;

    et_cust_data = SELECT c.CustomerId, c.CustomerName
                   FROM "/ZUORA001/I_CUSTA" AS c
                   INNER JOIN :lt_split_ids AS lsi ON lsi.SINGLE_VAL = c.CustomerId
                   WHERE c.Status = '1';

  ENDMETHOD.
ENDCLASS.
