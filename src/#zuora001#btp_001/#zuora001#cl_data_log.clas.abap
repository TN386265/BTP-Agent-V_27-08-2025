CLASS /zuora001/cl_data_log DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS:
      customer FOR TABLE FUNCTION /zuora001/tf_cstlog,
      custcapb FOR TABLE FUNCTION /zuora001/tf_cpbclog,
      destination FOR TABLE FUNCTION /zuora001/tf_destlog,
      mpac0 FOR TABLE FUNCTION /zuora001/tf_mapc0log.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/CL_DATA_LOG IMPLEMENTATION.


  METHOD custcapb BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_cpbca /zuora001/i_cpbtav.

    lt_capb_base = select current_row.CustomerId, current_row.CapabilityId, current_row.ValidFrom,
                           prev_row.ValidFrom as Prev_ValidFrom
                    from "/ZUORA001/I_CPBCA" AS current_row
                    left join lateral
                    (
                        select prev.CustomerId, prev.CapabilityId, max( prev.ValidFrom ) as ValidFrom
                        from "/ZUORA001/I_CPBCA" AS prev
                        where prev.CustomerId = current_row.CustomerId and prev.CapabilityId = current_row.CapabilityId and prev.ValidFrom < current_row.ValidFrom
                        group by prev.CustomerId, prev.CapabilityId

                     ) as prev_row on prev_row.CustomerId = current_row.CustomerId and prev_row.CapabilityId = current_row.CapabilityId;

    return
        select session_context('CDS_CLIENT') as Client, cpb.CustomerId, cpb.CapabilityId, cpbt.CapabilityName as CapabilityName,
               cpb.ValidFrom, cpb_log.ValidFrom as ValidFrom_old,
               cpb.ValidTo, cpb_log.ValidTo as ValidTo_old,
               cpb.ActivatedDate, cpb_log.ActivatedDate as ActivatedDate_old,
               cpb.ExpiryDate, cpb_log.ExpiryDate as ExpiryDate_old,
               cpb.Active, cpb_log.Active as Active_old,
               cpb.Status, cpb_log.Status as Status_old,
               cpb.CreatedBy, cpb.CreatedAt, cpb.LocalChangedBy, cpb.LocalLastChangedAt, cpb.LastChangedAt
        from "/ZUORA001/I_CPBCA" AS cpb
        inner join "/ZUORA001/I_CPBTAV" AS cpbt ON cpbt.CapabilityId = cpb.CapabilityId
        inner join :lt_capb_base as lt_base on lt_base.CustomerId = cpb.CustomerId and lt_base.CapabilityId = cpb.CapabilityId and
                                                    lt_base.ValidFrom = cpb.ValidFrom
        left outer join "/ZUORA001/I_CPBCA" AS cpb_log ON cpb_log.CustomerId = lt_base.CustomerId AND cpb_log.CapabilityId = lt_base.CapabilityId AND
                                                          cpb_log.ValidFrom = lt_base.Prev_ValidFrom;

  endmethod.


  METHOD customer BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_custa.

    lt_cust_base = select current_row.CustomerId, current_row.ValidFrom as ValidFrom,
                           prev_row.ValidFrom as Prev_ValidFrom
                    from "/ZUORA001/I_CUSTA" AS current_row
                    left join lateral
                    (
                        select prev.CustomerId, max( prev.ValidFrom ) as ValidFrom
                        from "/ZUORA001/I_CUSTA" AS prev
                        where prev.CustomerId = current_row.CustomerId and prev.ValidFrom < current_row.ValidFrom
                        group by prev.CustomerId

                     ) as prev_row on prev_row.CustomerId = current_row.CustomerId;

    return
        select session_context('CDS_CLIENT') as Client, cust.CustomerId,
               cust.ValidFrom, cust_log.ValidFrom as ValidFrom_old,
               cust.ValidTo, cust_log.ValidTo as ValidTo_old,
               cust.CustomerName, cust_log.CustomerName as CustomerName_old,
               cust.ActivatedDate, cust_log.ActivatedDate as ActivatedDate_old,
               cust.ExpiryDate, cust_log.ExpiryDate as ExpiryDate_old,
               cust.Active, cust_log.Active as Active_old,
               cust.Status, cust_log.Status as Status_old,
               cust.CreatedBy, cust.CreatedAt, cust.LocalChangedBy, cust.LocalLastChangedAt, cust.LastChangedAt
        from "/ZUORA001/I_CUSTA" AS cust
        inner join :lt_cust_base as lt_base on lt_base.CustomerId = cust.CustomerId and lt_base.ValidFrom = cust.ValidFrom
        left outer join "/ZUORA001/I_CUSTA" AS cust_log ON cust_log.CustomerId = lt_base.CustomerId AND cust_log.ValidFrom = lt_base.Prev_ValidFrom;

  endmethod.


  METHOD destination BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_desta /zuora001/i_cpbtav.

    lt_dest_base = select current_row.CustomerId, current_row.Destinationid, current_row.ValidFrom,
                           prev_row.ValidFrom as Prev_ValidFrom
                    from "/ZUORA001/I_DESTA" AS current_row
                    left join lateral
                    (
                        select prev.CustomerId, prev.Destinationid, max( prev.ValidFrom ) as ValidFrom
                        from "/ZUORA001/I_DESTA" AS prev
                        where prev.CustomerId = current_row.CustomerId and prev.Destinationid = current_row.Destinationid and prev.ValidFrom < current_row.ValidFrom
                        group by prev.CustomerId, prev.Destinationid

                     ) as prev_row on prev_row.CustomerId = current_row.CustomerId and prev_row.Destinationid = current_row.Destinationid;


    return
        select session_context('CDS_CLIENT') as Client, dest.CustomerId, dest.Destinationid,
               dest.ValidFrom, dest_log.ValidFrom as ValidFrom_old,
               dest.ValidTo, dest_log.ValidTo as ValidTo_old,
               dest.DestinationName, dest_log.DestinationName as DestinationName_old,
               dest.Description, dest_log.Description as Description_old,
               dest.CapabilityId, dest_log.CapabilityId as CapabilityId_old,
               cpbt.CapabilityName, cpbt_log.CapabilityName as CapabilityName_old,
               dest.DestUsrl, dest_log.DestUsrl as DestUsrl_old,
               dest.DestType, dest_log.DestType as DestType_old,
               dest.ProxyType, dest_log.ProxyType as ProxyType_old,
               dest.AuthType, dest_log.AuthType as AuthType_old,
               dest.AuthUser, dest_log.AuthUser as AuthUser_old,
               dest.SystemId, dest_log.SystemId as SystemId_old,
               dest.LandScape, dest_log.LandScape as LandScape_old,
               dest.Status, dest_log.Status as Status_old,
               dest.CreatedBy, dest.CreatedAt, dest.LocalChangedBy, dest.LocalLastChangedAt, dest.LastChangedAt
        from "/ZUORA001/I_DESTA" AS dest
        inner join :lt_dest_base as lt_base on lt_base.CustomerId = dest.CustomerId and lt_base.Destinationid = dest.Destinationid and lt_base.ValidFrom = dest.ValidFrom
        left outer join "/ZUORA001/I_DESTA" AS dest_log ON dest_log.CustomerId = lt_base.CustomerId AND dest_log.Destinationid = lt_base.Destinationid AND dest_log.ValidFrom = lt_base.Prev_ValidFrom
        left outer join "/ZUORA001/I_CPBTAV" AS cpbt ON cpbt.CapabilityId = dest.CapabilityId
        left outer join "/ZUORA001/I_CPBTAV" AS cpbt_log ON cpbt_log.CapabilityId = dest_log.CapabilityId;


  endmethod.


  METHOD mpac0 BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING /zuora001/i_mapc0 /zuora001/i_cpbtav.

    lt_mapc_base = select current_row.CustomerId, current_row.Destinationid, current_row.DestinationName,
                          current_row.CapabilityId, current_row.RuleId, current_row.ConditionSeq, current_row.TargetSeq,
                          current_row.ValidFrom, prev_row.ValidFrom as Prev_ValidFrom
                    from "/ZUORA001/I_MAPC0" AS current_row
                    left join lateral
                    (
                        select prev.CustomerId, prev.Destinationid, prev.DestinationName,
                               prev.CapabilityId, prev.RuleId, prev.ConditionSeq, prev.TargetSeq,
                               max( prev.ValidFrom ) as ValidFrom
                        from "/ZUORA001/I_MAPC0" AS prev
                        where prev.CustomerId = current_row.CustomerId and prev.Destinationid = current_row.Destinationid and
                              prev.DestinationName = current_row.DestinationName and prev.CapabilityId = current_row.CapabilityId and
                              prev.RuleId = current_row.RuleId and prev.ConditionSeq = current_row.ConditionSeq and
                              prev.TargetSeq = current_row.TargetSeq and
                              prev.ValidFrom < current_row.ValidFrom
                        group by prev.CustomerId, prev.Destinationid, prev.DestinationName,
                                 prev.CapabilityId, prev.RuleId, prev.ConditionSeq, prev.TargetSeq

                     ) as prev_row on prev_row.CustomerId = current_row.CustomerId and prev_row.Destinationid = current_row.Destinationid and
                                      prev_row.DestinationName = current_row.DestinationName and prev_row.CapabilityId = current_row.CapabilityId and
                                      prev_row.RuleId = current_row.RuleId and prev_row.ConditionSeq = current_row.ConditionSeq and
                                      prev_row.TargetSeq = current_row.TargetSeq;


     return
     select session_context('CDS_CLIENT') as Client, mapc.CustomerId, mapc.Destinationid, mapc.DestinationName,
            mapc.CapabilityId, cpbt.CapabilityName, mapc.RuleId, mapc.ConditionSeq, mapc.TargetSeq,
            mapc.ValidFrom, mapc_log.ValidFrom as ValidFrom_old,
            mapc.ValidTo, mapc_log.ValidTo as ValidTo_old,
            mapc.RuleDescription, mapc_log.RuleDescription as RuleDescription_old,
            mapc.ActivatedDate, mapc_log.ActivatedDate as ActivatedDate_old,
            mapc.ExpiryDate, mapc_log.ExpiryDate as ExpiryDate_old,
            mapc.SourceField, mapc_log.SourceField as SourceField_old,
            mapc.TargetField, mapc_log.TargetField as TargetField_old,
            mapc.SourceValue, mapc_log.SourceValue as SourceValue_old,
            mapc.TargetValue, mapc_log.TargetValue as TargetValue_old,
            mapc.MappingType, mapc_log.MappingType as MappingType_old,
            mapc.SourceData, mapc_log.SourceData as SourceData_old,
            mapc.TargetData, mapc_log.TargetData as TargetData_old,
            mapc.SourceCondition, mapc_log.SourceCondition as SourceCondition_old,
            mapc.ObjType, mapc_log.ObjType as ObjType_old,
            mapc.ValueType, mapc_log.ValueType as ValueType_old,
            mapc.RangeEndValue, mapc_log.RangeEndValue as RangeEndValue_old,
            mapc.Status, mapc_log.Status as Status_old,
            mapc.CreatedBy, mapc.CreatedAt, mapc.LocalChangedBy, mapc.LocalLastChangedAt, mapc.LastChangedAt
     from "/ZUORA001/I_MAPC0" AS mapc
     inner join :lt_mapc_base as lt_base on lt_base.CustomerId = mapc.CustomerId and lt_base.Destinationid = mapc.Destinationid and
                                            lt_base.DestinationName = mapc.DestinationName and lt_base.CapabilityId = mapc.CapabilityId and
                                            lt_base.RuleId = mapc.RuleId and lt_base.ConditionSeq = mapc.ConditionSeq and lt_base.TargetSeq = mapc.TargetSeq and
                                            lt_base.ValidFrom = mapc.ValidFrom
     left outer join "/ZUORA001/I_MAPC0" AS mapc_log ON mapc_log.CustomerId = lt_base.CustomerId AND mapc_log.Destinationid = lt_base.Destinationid AND
                                            mapc_log.DestinationName = lt_base.DestinationName and mapc_log.CapabilityId = lt_base.CapabilityId and
                                            mapc_log.RuleId = lt_base.RuleId and mapc_log.ConditionSeq = lt_base.ConditionSeq and
                                            mapc_log.TargetSeq = lt_base.TargetSeq and mapc_log.ValidFrom = lt_base.Prev_ValidFrom
     left outer join "/ZUORA001/I_CPBTAV" AS cpbt ON cpbt.CapabilityId = mapc.CapabilityId;


  endmethod.
ENDCLASS.
