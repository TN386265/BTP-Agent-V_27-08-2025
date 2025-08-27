CLASS /zuora001/bl_validation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    CONSTANTS :gv_active TYPE /zuora001/i_cust-Status VALUE '1'.
    DATA:ls_ret              TYPE /zuora001/t_bl_r,
         gv_customer_id      TYPE /zuora001/decustomerid,
         gv_destination_name TYPE /zuora001/t_dest-destination_name,
         gv_destination_system TYPE /zuora001/t_dest-system_id.

    DATA:gt_Customer_master TYPE STANDARD TABLE OF /zuora001/i_cust,
         gt_dest_master     TYPE STANDARD TABLE OF /zuora001/i_dest,
         gt_VALUE_MAPPING   TYPE STANDARD TABLE OF /zuora001/c_je_mapc,
         gs_dest_master     TYPE  /zuora001/i_dest,
         gs_Customer_master TYPE  /zuora001/i_cust.

    TYPES:gt_invoice_return TYPE STANDARD TABLE OF  /zuora001/t_bl_r,
          gt_item_record    TYPE STANDARD TABLE OF /zuora001/t_bl_i.

    METHODS validate_header
      IMPORTING REFERENCE(is_header_check) TYPE  /zuora001/t_bl_h
      EXPORTING REFERENCE(gt_invoice_ret)  TYPE gt_invoice_return.

    METHODS value_mapping_transform
      CHANGING REFERENCE(is_header_check) TYPE  /zuora001/t_bl_h
               REFERENCE(it_item_record)  TYPE  gt_item_record
               REFERENCE(gt_invoice_ret)  TYPE gt_invoice_return.


    METHODS validate_rev_header
      IMPORTING REFERENCE(is_header_check)    TYPE  /zuora001/t_revh
                REFERENCE(destination_name)   TYPE /zuora001/t_je_h-destination_name OPTIONAL
                REFERENCE(destination_system) TYPE /zuora001/t_je_h-destination_system OPTIONAL
                REFERENCE(gv_id)              TYPE sysuuid_x16 OPTIONAL
                REFERENCE(gv_customer_id)     TYPE /zuora001/t_je_h-customer_id OPTIONAL
      EXPORTING REFERENCE(gt_invoice_ret)     TYPE gt_invoice_return.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/BL_VALIDATION IMPLEMENTATION.


  METHOD validate_header.
    CLEAR:ls_ret,gv_customer_id,gv_destination_name .
    " Validate customer_id
    IF is_header_check-customer_id IS INITIAL.
      ls_ret-type  = 'RW'.
      ls_ret-je_uid = is_header_check-je_uid.
      ls_ret-customer_id = is_header_check-customer_id.
      ls_ret-number_n  = '101'.
      ls_ret-type  = 'E'.
      ls_ret-message = TEXT-002 ."'Please enter a customer ID'.
      APPEND ls_ret TO gt_invoice_ret.
      CLEAR ls_ret.
    ENDIF.

    IF is_header_check-destination_name IS INITIAL.
      ls_ret-type  = 'RW'.
      ls_ret-je_uid = is_header_check-je_uid.
       ls_ret-customer_id = is_header_check-customer_id.
      ls_ret-number_n  = '102'.
      ls_ret-type  = 'E'.
      ls_ret-message = TEXT-006.
      APPEND ls_ret TO gt_invoice_ret.
      CLEAR ls_ret.
    ENDIF.

    " Validate Username
    IF is_header_check-Username IS INITIAL.
      ls_ret-type  = 'RW'.
      ls_ret-je_uid = is_header_check-je_uid.
       ls_ret-customer_id = is_header_check-customer_id.
      ls_ret-number_n  = '104'.
      ls_ret-type  = 'E'.
      ls_ret-message = TEXT-008.
      APPEND ls_ret TO gt_invoice_ret.
      CLEAR ls_ret.
    ENDIF.

    IF gt_invoice_ret[] IS INITIAL.
      gv_customer_id = is_header_check-customer_id.
      gv_destination_name = is_header_check-destination_name.
      gv_destination_system = is_header_check-destination_system.
      DATA:gv_timestamp1 TYPE /zuora001/t_cust-created_at.
      GET TIME STAMP FIELD gv_timestamp1.
      DATA(lv_current_date) = CONV d( cl_abap_context_info=>get_system_date( ) ).
      IF gv_destination_name IS NOT INITIAL AND gv_customer_id IS NOT INITIAL
        AND gv_destination_system IS NOT INITIAL.
        SELECT SINGLE FROM /zuora001/i_dest
               FIELDS CustomerId, Destinationid, ValidFrom, ValidTo, DestinationName
               WHERE CustomerId = @gv_customer_id
               AND DestinationName = @gv_destination_name
               AND SystemId = @gv_destination_system
               INTO @gs_dest_master .
        IF sy-subrc <> 0 AND gs_dest_master IS INITIAL.
          ls_ret-type  = 'RW'.
          ls_ret-je_uid = is_header_check-je_uid.
           ls_ret-customer_id = is_header_check-customer_id.
          ls_ret-number_n  = '107'.
          ls_ret-type  = 'E'.
          ls_ret-message = |{ TEXT-003 } { gv_customer_id } { TEXT-004 } { gv_destination_name } { TEXT-016 } { is_header_check-destination_system } { TEXT-005 }|.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR: ls_ret.
        ENDIF.
      ELSEIF gv_destination_name IS NOT INITIAL AND gv_customer_id IS NOT INITIAL.
        SELECT SINGLE FROM /zuora001/i_dest
                FIELDS CustomerId, Destinationid, ValidFrom, ValidTo, DestinationName
                WHERE CustomerId = @gv_customer_id
                AND DestinationName = @gv_destination_name
                INTO @gs_dest_master .

        IF sy-subrc <> 0 AND gs_dest_master IS INITIAL.
          ls_ret-type  = 'RW'.
          ls_ret-je_uid = is_header_check-je_uid.
           ls_ret-customer_id = is_header_check-customer_id.
          ls_ret-number_n  = '108'.
          ls_ret-type  = 'E'.
          ls_ret-message = |{ TEXT-003 } { gv_customer_id } { TEXT-004 } { gv_destination_name } { TEXT-005 }|.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR: ls_ret.
        ENDIF.
      ENDIF.


      IF gv_customer_id IS NOT INITIAL.
* Check if the customer_id exists in the Master Table
        SELECT SINGLE FROM /zuora001/i_cust
               FIELDS CustomerId,validfrom ,validto ,customername,ActivatedDate,ExpiryDate,active,status
               WHERE CustomerId = @gv_customer_id
                 AND Active = @gv_active
                 AND Status = @gv_active
               INTO @gs_Customer_master.
        IF gs_customer_master IS INITIAL.
          ls_ret-type  = 'RW'.
          ls_ret-je_uid = is_header_check-je_uid.
           ls_ret-customer_id = is_header_check-customer_id.
          ls_ret-number_n  = '109'.
          ls_ret-type  = 'E'.
          ls_ret-message = |{ TEXT-003 } { gv_customer_id } { TEXT-005 }.|.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR: ls_ret.
        ELSEIF gs_customer_master-Status <> gv_active.
          ls_ret-type  = 'RW'.
          ls_ret-je_uid = is_header_check-je_uid.
           ls_ret-customer_id = is_header_check-customer_id.
          ls_ret-number_n  = '110'.
          ls_ret-type  = 'E'.
          ls_ret-message = |{ TEXT-003 } { gv_customer_id } { TEXT-012 } { gv_destination_name } { TEXT-013 }|.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR: ls_ret.
        ELSE.
          IF  gs_customer_master-ActivatedDate <= lv_current_date AND  gs_customer_master-ExpiryDate >= lv_current_date.
          ELSE.
            ls_ret-type  = 'RW'.
            ls_ret-number_n  = '111'.
            ls_ret-je_uid = is_header_check-je_uid.
            ls_ret-customer_id = is_header_check-customer_id.
            ls_ret-type  = 'E'.
            ls_ret-message = |{ TEXT-014 } { gv_customer_id } { TEXT-015 } { gs_customer_master-ValidTo } { TEXT-013 }|.
            APPEND ls_ret TO gt_invoice_ret.
            CLEAR: ls_ret.
          ENDIF.
        ENDIF.
      ENDIF.
      " Validate destination_name
      " Validate DocType
    ENDIF.
  ENDMETHOD.


  METHOD validate_rev_header.

    DATA:gv_customer_id_rev        TYPE /zuora001/decustomerid,
         gv_destination_name_rev   TYPE /zuora001/t_dest-destination_name,
         gv_destination_system_rev TYPE /zuora001/t_dest-system_id.

    " Validate Username
    IF is_header_check-Username IS INITIAL.
      ls_ret-type  = 'RW'.
      ls_ret-number_n  = '112'.
      ls_ret-je_uid = gv_id.
      ls_ret-customer_id = gv_customer_id.
      ls_ret-destination_name = destination_name.
      ls_ret-type  = 'E'.
      ls_ret-message = TEXT-008.
      APPEND ls_ret TO gt_invoice_ret.
      CLEAR ls_ret.
    ENDIF.
    " Validate pstngdate
    IF is_header_check-pstng_date IS INITIAL.
      ls_ret-type  = 'RW'.
      ls_ret-number_n  = '113'.
      ls_ret-je_uid = gv_id.
      ls_ret-customer_id = gv_customer_id.
      ls_ret-destination_name = destination_name.
      ls_ret-type  = 'E'.
      ls_ret-message = TEXT-010.
      APPEND ls_ret TO gt_invoice_ret.
      CLEAR ls_ret.
    ENDIF.

    IF is_header_check-obj_key_r IS INITIAL.
      ls_ret-type  = 'RW'.
      ls_ret-number_n  = '114'.
      ls_ret-type  = 'E'.
      ls_ret-message = TEXT-011.
      APPEND ls_ret TO gt_invoice_ret.
      CLEAR ls_ret.
    ENDIF.
    IF gt_invoice_ret[] IS INITIAL.
      gv_customer_id_rev = is_header_check-customer_id.
      gv_destination_name_rev = is_header_check-destination_name.
      gv_destination_system_rev = is_header_check-destination_system.
      DATA:gv_timestamp1 TYPE /zuora001/t_cust-created_at.
      GET TIME STAMP FIELD gv_timestamp1.
      DATA(lv_current_date) = CONV d( cl_abap_context_info=>get_system_date( ) ).
      IF gv_destination_name_rev IS NOT INITIAL AND gv_customer_id_rev IS NOT INITIAL
        AND gv_destination_system_rev IS NOT INITIAL.
        SELECT SINGLE FROM /zuora001/i_dest
               FIELDS CustomerId, Destinationid, ValidFrom, ValidTo, DestinationName
               WHERE CustomerId = @gv_customer_id_rev
               AND DestinationName = @gv_destination_name_rev
               AND SystemId = @gv_destination_system_rev
               INTO @gs_dest_master .
        IF sy-subrc <> 0 AND gs_dest_master IS INITIAL.
         ls_ret-je_uid = gv_id.
         ls_ret-customer_id = gv_customer_id.
         ls_ret-destination_name = destination_name.
          ls_ret-type  = 'RW'.
          ls_ret-number_n  = '107'.
          ls_ret-type  = 'E'.
          ls_ret-message = |{ TEXT-003 } { gv_customer_id_rev } { TEXT-004 } { gv_destination_name_rev } { TEXT-016 } { is_header_check-destination_system } { TEXT-005 }|.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR: ls_ret.
        ENDIF.
      ELSEIF gv_destination_name_rev IS NOT INITIAL AND gv_customer_id_rev IS NOT INITIAL.
        SELECT SINGLE FROM /zuora001/i_dest
                FIELDS CustomerId, Destinationid, ValidFrom, ValidTo, DestinationName
                WHERE CustomerId = @gv_customer_id_rev
                AND DestinationName = @gv_destination_name_rev
                INTO @gs_dest_master .

        IF sy-subrc <> 0 AND gs_dest_master IS INITIAL.
          ls_ret-je_uid = gv_id.
          ls_ret-customer_id = gv_customer_id.
          ls_ret-destination_name = destination_name.
          ls_ret-type  = 'RW'.
          ls_ret-number_n  = '108'.
          ls_ret-type  = 'E'.
          ls_ret-message = |{ TEXT-003 } { gv_customer_id_rev } { TEXT-004 } { gv_destination_name_rev } { TEXT-005 }|.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR: ls_ret.
        ENDIF.
      ENDIF.
    ENDIF.


  ENDMETHOD.


  METHOD value_mapping_transform.
*&----------------------------------------------------------------------------------------------->
    DATA: lv_source_field_value TYPE string,
          lv_target_field_name  TYPE string,
          lv_source_condition   TYPE string,  " Variable to store the source condition
          lv_operator           TYPE string,  " Variable to store the operator
          lv_comparison_value   TYPE string,  " Variable to store the comparison value
          gt_value_mapping      TYPE TABLE OF /zuora001/i_mapc,  " Internal table to hold mappings
          ls_value_mapping      TYPE /zuora001/i_mapc.           " Work area for mapping entry
    FIELD-SYMBOLS : <fs_head> TYPE /zuora001/t_bl_h.
    ASSIGN is_header_check TO <fs_head>.
    " Step 1: Check if the header text is 'ZUORA' before processing
    " Step 2: Ensure there are records in the item data
    IF it_item_record[] IS NOT INITIAL .
      " Step 3: Select mapping data for the given customer and destination from the mapping table
      DATA(lv_current_date) = CONV d( cl_abap_context_info=>get_system_date( ) ).
      SELECT *
        FROM /zuora001/i_mapc
        WHERE CustomerId = @is_header_check-customer_id
          AND DestinationName = @is_header_check-destination_name
          AND capabilityid = '1' " Adjust as needed for capabilityid
          AND Status = @gv_active
        INTO TABLE @gt_value_mapping.
      DATA: gv_timestamp_char(14) TYPE c,
            gv_valid_from         TYPE d,
            gv_valid_from_str     TYPE string,
            gv_valid_to_str       TYPE string,
            gv_valid_to           TYPE d.
      " Step 4: If mapping entries were found, process each item record
      IF gt_value_mapping[] IS NOT INITIAL.
        LOOP AT it_item_record ASSIGNING FIELD-SYMBOL(<fs_item>).
          " Loop over each mapping entry
          LOOP AT gt_value_mapping INTO ls_value_mapping.
            gv_valid_from_str = ls_value_mapping-validfrom.
            gv_valid_to_str   = ls_value_mapping-validto.
            " Extract the first 8 characters (YYYYMMDD) for VALIDFROM
            gv_valid_from = gv_valid_from_str+0(8).
            " Extract the first 8 characters (YYYYMMDD) for VALIDTO
            gv_valid_to = gv_valid_to_str+0(8).
            IF lv_current_date BETWEEN gv_valid_from AND gv_valid_to.
              " Step 5: Translate the source field name to uppercase for consistency
              TRANSLATE ls_value_mapping-SourceField TO UPPER CASE.
              " Step 6: Dynamically assign the source field value from the item record
              ASSIGN COMPONENT ls_value_mapping-SourceField OF STRUCTURE <fs_head> TO FIELD-SYMBOL(<fs_source_field>).
              IF <fs_source_field> IS NOT ASSIGNED.
               ASSIGN COMPONENT ls_value_mapping-SourceField OF STRUCTURE <fs_item> TO <fs_source_field>.
              ENDIF.

                " Step 7: Split the source condition into operator and value (e.g., '=1000')
                IF ls_value_mapping-SourceValue CP '=*'.
                  lv_operator = '='.
                  lv_comparison_value = ls_value_mapping-SourceValue+1.
                  lv_source_field_value =  <fs_source_field>  . " Skip the operator
                ELSEIF ls_value_mapping-SourceValue CP '<*'.
                  lv_operator = '<'.
                  lv_comparison_value = ls_value_mapping-SourceValue+1.  " Skip the operator
                  lv_source_field_value =  <fs_source_field>  .
                ELSEIF ls_value_mapping-SourceValue CP '>*'.
                  lv_operator = '>'.
                  lv_comparison_value = ls_value_mapping-SourceValue+1.  " Skip the operator
                  lv_source_field_value =  <fs_source_field>  .
                ELSEIF ls_value_mapping-SourceValue CP '<>*'.
                  lv_operator = '<>'.
                  lv_comparison_value = ls_value_mapping-SourceValue+2.  " Skip the operator
                  lv_source_field_value =  <fs_source_field>  .
                ELSE.
                  " If no operator found, assume '='
                  lv_operator = '='.
                  lv_comparison_value = ls_value_mapping-SourceValue.
                  lv_source_field_value =  <fs_source_field>  .
                ENDIF.

                " Step 8: Handle different operators dynamically
                CASE lv_operator.
                  WHEN '='.
                    IF lv_source_field_value = lv_comparison_value.
                      " Step 9: If match found, dynamically assign the target field
                      lv_target_field_name = ls_value_mapping-TargetField.
                      ASSIGN COMPONENT ls_value_mapping-TargetField OF STRUCTURE <fs_head>  TO FIELD-SYMBOL(<fs_target_field>).
                      IF sy-subrc = 0.
                        " Step 10: Set the target field value according to the mapping
                        <fs_target_field> = ls_value_mapping-TargetValue+1. " Apply the transformation
                      ELSE.
                        " If assignment from item record failed, try with header structure
                        ASSIGN COMPONENT ls_value_mapping-TargetField OF STRUCTURE <fs_item> TO <fs_target_field>.
                        IF sy-subrc = 0.
                          " If assignment from header is successful, apply the value
                          <fs_target_field> = ls_value_mapping-TargetValue+1.
                        ENDIF.
                      ENDIF.
                    ENDIF.

                  WHEN '<'.
                    IF lv_source_field_value < lv_comparison_value.
                      " Handle < condition and apply target value
                      lv_target_field_name = ls_value_mapping-TargetField.
                      ASSIGN COMPONENT ls_value_mapping-TargetField OF STRUCTURE  <fs_head>  TO <fs_target_field>.
                      IF sy-subrc = 0.
                        <fs_target_field> = ls_value_mapping-TargetValue.
                      ELSE.
                        " If assignment from item record failed, try with header structure
                        ASSIGN COMPONENT ls_value_mapping-TargetField OF STRUCTURE <fs_item> TO <fs_target_field>.
                        IF sy-subrc = 0.
                          <fs_target_field> = ls_value_mapping-TargetValue.
                        ENDIF.
                      ENDIF.
                    ENDIF.

                  WHEN '>'.
                    IF lv_source_field_value > lv_comparison_value.
                      " Handle > condition and apply target value
                      lv_target_field_name = ls_value_mapping-TargetField.
                      ASSIGN COMPONENT ls_value_mapping-TargetField OF STRUCTURE <fs_head>  TO <fs_target_field>.
                      IF sy-subrc = 0.
                        <fs_target_field> = ls_value_mapping-TargetValue.
                      ELSE.
                        " If assignment from item record failed, try with header structure
                        ASSIGN COMPONENT ls_value_mapping-TargetField OF STRUCTURE <fs_item> TO <fs_target_field>.
                        IF sy-subrc = 0.
                          <fs_target_field> = ls_value_mapping-TargetValue.
                        ENDIF.
                      ENDIF.
                    ENDIF.

                  WHEN '<>'.
                    IF lv_source_field_value <> lv_comparison_value.
                      " Handle <> (not equal) condition and apply target value
                      lv_target_field_name = ls_value_mapping-TargetField.
                      ASSIGN COMPONENT ls_value_mapping-TargetField OF STRUCTURE <fs_head> TO <fs_target_field>.
                      IF sy-subrc = 0.
                        <fs_target_field> = ls_value_mapping-TargetValue.
                      ELSE.
                        " If assignment from item record failed, try with header structure
                        ASSIGN COMPONENT ls_value_mapping-TargetField OF STRUCTURE <fs_item> TO <fs_target_field>.
                        IF sy-subrc = 0.
                          <fs_target_field> = ls_value_mapping-TargetValue.
                        ENDIF.
                      ENDIF.
                    ENDIF.
                  WHEN OTHERS.
                    " Handle other operators if necessary
                ENDCASE.
              ENDIF. " If source field exists in the item record
            CLEAR:ls_value_mapping,gv_valid_from,gv_valid_to.
          ENDLOOP. " End mapping loop
        ENDLOOP. " End item record loop
      ENDIF. " If value mappings are found
      IF <fs_head> IS ASSIGNED.
        is_header_check = <fs_head>.
      ENDIF.
    ENDIF. " If item records are not initial
*&------------------------------------------------------------------------------------------------>
  ENDMETHOD.
ENDCLASS.
