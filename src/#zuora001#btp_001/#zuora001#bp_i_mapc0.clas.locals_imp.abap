CLASS lhc_Mapc DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      mt_root_to_create TYPE STANDARD TABLE OF /zuora001/t_mapc WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_update TYPE STANDARD TABLE OF /zuora001/t_mapc WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_delete TYPE STANDARD TABLE OF /zuora001/t_mapc WITH NON-UNIQUE DEFAULT KEY.
    DATA : lw_mapc TYPE /zuora001/t_mapc.

  PRIVATE SECTION.
    TYPES:
        ty_action(2) TYPE c.
    CONSTANTS:
      BEGIN OF cs_action,
        create TYPE ty_action VALUE '01',
        update TYPE ty_action VALUE '02',
        delete TYPE ty_action VALUE '03',
      END OF cs_action.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Mapc.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Mapc.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Mapc.

    METHODS read FOR READ
      IMPORTING keys FOR READ Mapc RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Mapc.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Mapc RESULT result.

    METHODS validate
      IMPORTING
        iv_action         TYPE ty_action
        is_mapc           TYPE /zuora001/i_mapc0
      RETURNING
        VALUE(rv_message) TYPE string.

ENDCLASS.

CLASS lhc_Mapc IMPLEMENTATION.

  METHOD create.

    DATA : lv_rule_id     TYPE /zuora001/t_mapc-rule_id,
           lv_rule_id_new TYPE /zuora001/t_mapc-rule_id,
           lv_tstmp       TYPE /zuora001/t_mapc-created_at.

    LOOP AT entities INTO DATA(ls_root_to_create).
      DATA(lv_message) = validate( iv_action = cs_action-create is_mapc = CORRESPONDING /zuora001/i_mapc0( ls_root_to_create ) ).

      IF lv_message IS INITIAL.
        ls_root_to_create-Status = '1'.
        ls_root_to_create-CreatedBy = sy-uname.
        GET TIME STAMP FIELD lv_tstmp.

        ls_root_to_create-CreatedAt = lv_tstmp.
        ls_root_to_create-LocalLastChangedAt = lv_tstmp.

        IF ls_root_to_create-RuleId IS INITIAL OR ls_root_to_create-RuleId = '0000'.
          SELECT MAX( rule_id ) FROM /zuora001/t_mapc WHERE customer_id = @ls_root_to_create-CustomerId INTO @lv_rule_id.

          IF lv_rule_id IS NOT INITIAL.
            lv_rule_id = lv_rule_id + 1.
            IF lv_rule_id_new IS INITIAL.
              lv_rule_id_new = lv_rule_id.
            ELSE.
              lv_rule_id_new = lv_rule_id_new + 1.
            ENDIF.
          ELSE.
            lv_rule_id = 1.
            IF lv_rule_id_new IS INITIAL.
              lv_rule_id_new = lv_rule_id.
            ELSE.
              lv_rule_id_new = lv_rule_id_new + 1.
            ENDIF.
          ENDIF.

          ls_root_to_create-RuleId = lv_rule_id_new.
        ENDIF.



        ls_root_to_create-ConditionSeq = 1.
        ls_root_to_create-TargetSeq = 1.

        INSERT CORRESPONDING #( ls_root_to_create ) INTO TABLE mapped-mapc.

        CLEAR lw_mapc.
        lw_mapc-customer_id = ls_root_to_create-CustomerId.
        lw_mapc-destinationid = ls_root_to_create-Destinationid.
        lw_mapc-destination_name = ls_root_to_create-DestinationName.
        lw_mapc-capability_id = ls_root_to_create-CapabilityId.
        lw_mapc-rule_id = ls_root_to_create-RuleId.
        lw_mapc-condition_seq = ls_root_to_create-ConditionSeq.
        lw_mapc-target_seq = ls_root_to_create-TargetSeq.
        lw_mapc-valid_from = ls_root_to_create-ValidFrom.
        lw_mapc-valid_to = ls_root_to_create-ValidTo.
        lw_mapc-rule_description = ls_root_to_create-RuleDescription.
        lw_mapc-activated_date = ls_root_to_create-ActivatedDate.
        lw_mapc-expiry_date = ls_root_to_create-ExpiryDate.
        lw_mapc-source_field = ls_root_to_create-SourceField.
        lw_mapc-target_field = ls_root_to_create-TargetField.
        lw_mapc-source_value = ls_root_to_create-SourceValue.
        lw_mapc-target_value = ls_root_to_create-TargetValue.
        lw_mapc-mapping_type = ls_root_to_create-MappingType.
        lw_mapc-source_data = ls_root_to_create-SourceData.
        lw_mapc-target_data = ls_root_to_create-TargetData.
        lw_mapc-source_condition = ls_root_to_create-SourceCondition.
        lw_mapc-obj_type = ls_root_to_create-ObjType.
        lw_mapc-value_type = ls_root_to_create-ValueType.
        lw_mapc-range_end_value = ls_root_to_create-RangeEndValue.
        lw_mapc-status = ls_root_to_create-Status.
        lw_mapc-created_by = ls_root_to_create-CreatedBy.
        lw_mapc-created_at = ls_root_to_create-CreatedAt.
        lw_mapc-local_last_changed_at = ls_root_to_create-LocalLastChangedAt.

        INSERT CORRESPONDING #( lw_mapc ) INTO TABLE mt_root_to_create.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.

    DATA : lv_changed_timestamp TYPE /zuora001/t_mapc-last_changed_at,
           lv_created_by        TYPE /zuora001/t_mapc-created_by,
           lv_created_at        TYPE /zuora001/t_mapc-created_at.

    LOOP AT entities INTO DATA(ls_root_to_update).
      SELECT SINGLE FROM /zuora001/i_mapc0 FIELDS CustomerId, Destinationid, DestinationName, CapabilityId, RuleId, ConditionSeq, TargetSeq, ValidFrom,
                                                  ValidTo, RuleDescription, ActivatedDate, ExpiryDate, SourceField, TargetField, SourceValue, TargetValue,
                                                  MappingType, SourceData, TargetData, SourceCondition, ObjType, ValueType, RangeEndValue, Status,
                                                  CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt,
                                                  CreatedUserDescription, ChangedUserDescription
      WHERE CustomerId = @ls_root_to_update-CustomerId AND Destinationid = @ls_root_to_update-Destinationid AND
            DestinationName = @ls_root_to_update-DestinationName AND CapabilityId = @ls_root_to_update-CapabilityId AND
            RuleId = @ls_root_to_update-RuleId AND ConditionSeq = @ls_root_to_update-ConditionSeq AND
            TargetSeq = @ls_root_to_update-TargetSeq AND ValidFrom = @ls_root_to_update-ValidFrom
      INTO @DATA(ls_mapc).

      DATA(lt_control_components) = VALUE string_table(
          ( `CustomerId` )
          ( `Destinationid` )
          ( `DestinationName` )
          ( `CapabilityId` )
          ( `RuleId` )
          ( `ConditionSeq` )
          ( `TargetSeq` )
          ( `ValidFrom` )
          ( `ValidTo` )
          ( `RuleDescription` )
          ( `ActivatedDate` )
          ( `ExpiryDate` )
          ( `SourceField` )
          ( `TargetField` )
          ( `SourceValue` )
          ( `TargetValue` )
          ( `MappingType` )
          ( `SourceData` )
          ( `TargetData` )
          ( `SourceCondition` )
          ( `ObjType` )
          ( `ValueType` )
          ( `RangeEndValue` )
          ( `Status` )
          ( `CreatedBy` )
          ( `CreatedAt` )
          ( `LocalChangedBy` )
          ( `LocalLastChangedAt` )
          ( `LastChangedAt` )
      ).

      lv_created_by = ls_mapc-CreatedBy.
      lv_created_at = ls_mapc-CreatedAt.

      LOOP AT lt_control_components INTO DATA(lv_component_name).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update-%control TO FIELD-SYMBOL(<lv_control_value>).
        CHECK <lv_control_value> = cl_abap_behavior_handler=>flag_changed.
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update TO FIELD-SYMBOL(<lv_new_value>).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_mapc TO FIELD-SYMBOL(<lv_old_value>).
        <lv_old_value> = <lv_new_value>.
      ENDLOOP.

      ls_root_to_update-LocalChangedBy = sy-uname.
      GET TIME STAMP FIELD lv_changed_timestamp.
      ls_root_to_update-LastChangedAt = lv_changed_timestamp.
      ls_root_to_update-LocalLastChangedAt = lv_changed_timestamp.
      ls_root_to_update-CreatedBy = lv_created_by.
      ls_root_to_update-CreatedAt = lv_created_at.

      CLEAR lw_mapc.
      lw_mapc-customer_id = ls_root_to_update-CustomerId.
      lw_mapc-destinationid = ls_root_to_update-Destinationid.
      lw_mapc-destination_name = ls_root_to_update-DestinationName.
      lw_mapc-capability_id = ls_root_to_update-CapabilityId.
      lw_mapc-rule_id = ls_root_to_update-RuleId.
      lw_mapc-condition_seq = ls_root_to_update-ConditionSeq.
      lw_mapc-target_seq = ls_root_to_update-TargetSeq.
      lw_mapc-valid_from = ls_root_to_update-ValidFrom.
      lw_mapc-valid_to = ls_root_to_update-ValidTo.
      lw_mapc-rule_description = ls_root_to_update-RuleDescription.
      lw_mapc-activated_date = ls_root_to_update-ActivatedDate.
      lw_mapc-expiry_date = ls_root_to_update-ExpiryDate.
      lw_mapc-source_field = ls_root_to_update-SourceField.
      lw_mapc-target_field = ls_root_to_update-TargetField.
      lw_mapc-source_value = ls_root_to_update-SourceValue.
      lw_mapc-target_value = ls_root_to_update-TargetValue.
      lw_mapc-mapping_type = ls_root_to_update-MappingType.
      lw_mapc-source_data = ls_root_to_update-SourceData.
      lw_mapc-target_data = ls_root_to_update-TargetData.
      lw_mapc-source_condition = ls_root_to_update-SourceCondition.
      lw_mapc-obj_type = ls_root_to_update-ObjType.
      lw_mapc-value_type = ls_root_to_update-ValueType.
      lw_mapc-range_end_value = ls_root_to_update-RangeEndValue.
      lw_mapc-status = ls_root_to_update-Status.
      lw_mapc-created_by = ls_root_to_update-CreatedBy.
      lw_mapc-created_at = ls_root_to_update-CreatedAt.
      lw_mapc-local_changed_by = ls_root_to_update-LocalChangedBy.
      lw_mapc-local_last_changed_at = ls_root_to_update-LocalLastChangedAt.
      lw_mapc-last_changed_at = ls_root_to_update-LastChangedAt.

      DATA(lv_message) = validate( iv_action = cs_action-update is_mapc = ls_mapc ).

      INSERT lw_mapc INTO TABLE mt_root_to_update.
    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

    LOOP AT keys INTO DATA(ls_root_to_delete).
      SELECT SINGLE FROM /zuora001/i_mapc0 FIELDS *
      WHERE CustomerId = @ls_root_to_delete-CustomerId AND Destinationid = @ls_root_to_delete-Destinationid AND
            DestinationName = @ls_root_to_delete-DestinationName AND CapabilityId = @ls_root_to_delete-CapabilityId AND
            RuleId = @ls_root_to_delete-RuleId AND ConditionSeq = @ls_root_to_delete-ConditionSeq AND
            TargetSeq = @ls_root_to_delete-TargetSeq AND ValidFrom = @ls_root_to_delete-ValidFrom
      INTO @DATA(ls_mpac).

      CLEAR lw_mapc.
      lw_mapc-customer_id = ls_mpac-CustomerId.
      lw_mapc-destinationid = ls_mpac-Destinationid.
      lw_mapc-destination_name = ls_mpac-DestinationName.
      lw_mapc-capability_id = ls_mpac-CapabilityId.
      lw_mapc-rule_id = ls_mpac-RuleId.
      lw_mapc-condition_seq = ls_mpac-ConditionSeq.
      lw_mapc-target_seq = ls_mpac-TargetSeq.
      lw_mapc-valid_from = ls_mpac-ValidFrom.

      DATA(lv_message) = validate( iv_action = cs_action-delete is_mapc = ls_mpac ).

      INSERT CORRESPONDING #( lw_mapc ) INTO TABLE mt_root_to_delete.

    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
    LOOP AT keys INTO DATA(ls_root_to_lock).
      TRY.
          cl_abap_lock_object_factory=>get_instance( iv_name = '/ZUORA001/EMAPC' )->enqueue(
              it_table_mode = VALUE if_abap_lock_object=>tt_table_mode( ( table_name = '/zuora001/i_mapc0' ) )
              it_parameter = VALUE if_abap_lock_object=>tt_parameter(
                  ( name = 'RuleId' value = REF #( ls_root_to_lock-RuleId ) )
               )
           ).
        CATCH cx_abap_foreign_lock INTO DATA(lx_lock).
          APPEND VALUE #( RuleId = ls_root_to_lock-RuleId %fail = VALUE #( cause = if_abap_behv=>cause-locked ) ) TO failed-mapc.
          APPEND VALUE #( RuleId = ls_root_to_lock-RuleId %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = lx_lock->get_text( ) ) ) TO reported-mapc.
        CATCH cx_abap_lock_failure.
          ASSERT 1 = 0.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD validate.
  ENDMETHOD.

  METHOD get_global_authorizations.
    IF requested_authorizations-%update = if_abap_behv=>mk-on.
      result-%update = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_I_MAPC0 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_I_MAPC0 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    INSERT /zuora001/t_mapc FROM TABLE @lhc_mapc=>mt_root_to_create.
    UPDATE /zuora001/t_mapc FROM TABLE @lhc_mapc=>mt_root_to_update.
    DELETE /zuora001/t_mapc FROM TABLE @lhc_mapc=>mt_root_to_delete.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
