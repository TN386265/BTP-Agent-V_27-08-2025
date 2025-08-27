CLASS lhc_Mapv DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      mt_root_to_create TYPE STANDARD TABLE OF /zuora001/t_mapv WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_update TYPE STANDARD TABLE OF /zuora001/t_mapv WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_delete TYPE STANDARD TABLE OF /zuora001/t_mapv WITH NON-UNIQUE DEFAULT KEY.
    DATA : lw_mapv TYPE /zuora001/t_mapv.

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
      IMPORTING entities FOR CREATE Mapv.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Mapv.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Mapv.

    METHODS read FOR READ
      IMPORTING keys FOR READ Mapv RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Mapv.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Mapv RESULT result.

    METHODS validate
      IMPORTING
        iv_action         TYPE ty_action
        is_mapv           TYPE /zuora001/i_mapv
      RETURNING
        VALUE(rv_message) TYPE string.

ENDCLASS.

CLASS lhc_Mapv IMPLEMENTATION.

  METHOD create.
    DATA : lv_value_id TYPE /zuora001/t_mapv-value_id,
           lv_tstmp    TYPE /zuora001/t_mapv-created_at.

    LOOP AT entities INTO DATA(ls_root_to_create).
      DATA(lv_message) = validate( iv_action = cs_action-create is_mapv = CORRESPONDING /zuora001/i_mapv( ls_root_to_create ) ).

      IF lv_message IS INITIAL.
*        ls_root_to_create-Status = '1'.
        ls_root_to_create-CreatedBy = sy-uname.
        GET TIME STAMP FIELD lv_tstmp.

        ls_root_to_create-CreatedAt = lv_tstmp.
        ls_root_to_create-LocalLastChangedAt = lv_tstmp.

        ls_root_to_create-RuleId = '00001'.
        ls_root_to_create-ConditionSeq = 1.
        ls_root_to_create-TargetSeq = 1.

        SELECT MAX( value_id ) FROM /zuora001/t_mapv WHERE value_id > 0 INTO @lv_value_id.
        IF lv_value_id IS NOT INITIAL.
          lv_value_id = lv_value_id + 1.
        ELSE.
          lv_value_id = 1.
        ENDIF.
        ls_root_to_create-ValueId = lv_value_id.

        INSERT CORRESPONDING #( ls_root_to_create ) INTO TABLE mapped-mapv.

        CLEAR lw_mapv.
        lw_mapv-customer_id = ls_root_to_create-CustomerId.
        lw_mapv-rule_id = ls_root_to_create-RuleId.
        lw_mapv-condition_seq = ls_root_to_create-ConditionSeq.
        lw_mapv-target_seq = ls_root_to_create-TargetSeq.
        lw_mapv-value_id = ls_root_to_create-ValueId.
        lw_mapv-valid_from = ls_root_to_create-ValidFrom.
        lw_mapv-valid_to = ls_root_to_create-ValidTo.
        lw_mapv-source_value = ls_root_to_create-SourceValue.
        lw_mapv-target_value = ls_root_to_create-TargetValue.
        lw_mapv-source_condition = ls_root_to_create-SourceCondition.
        lw_mapv-target_condition = ls_root_to_create-TargetCondition.
        lw_mapv-status = ls_root_to_create-Status.
        lw_mapv-created_by = ls_root_to_create-CreatedBy.
        lw_mapv-created_at = ls_root_to_create-CreatedAt.
        lw_mapv-local_last_changed_at = ls_root_to_create-LocalLastChangedAt.

        INSERT CORRESPONDING #( lw_mapv ) INTO TABLE mt_root_to_create.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.

    DATA : lv_changed_timestamp TYPE /zuora001/t_mapv-last_changed_at,
           lv_created_by        TYPE /zuora001/t_mapv-created_by,
           lv_created_at        TYPE /zuora001/t_mapv-created_at.

    LOOP AT entities INTO DATA(ls_root_to_update).
      SELECT SINGLE FROM /zuora001/i_mapv FIELDS CustomerId, RuleId, ConditionSeq, TargetSeq, ValueId, ValidFrom, ValidTo,
                                                 SourceValue, TargetValue, SourceCondition, TargetCondition, Status,
                                                 CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt
      WHERE CustomerId = @ls_root_to_update-CustomerId AND RuleId = @ls_root_to_update-RuleId AND
            ConditionSeq = @ls_root_to_update-ConditionSeq AND TargetSeq = @ls_root_to_update-TargetSeq AND
            ValueId = @ls_root_to_update-ValueId AND ValidFrom = @ls_root_to_update-ValidFrom
      INTO @DATA(ls_mapv).

      DATA(lt_control_components) = VALUE string_table(
          ( `CustomerId` )
          ( `RuleId` )
          ( `ConditionSeq` )
          ( `TargetSeq` )
          ( `ValueId` )
          ( `ValidFrom` )
          ( `ValidTo` )
          ( `SourceValue` )
          ( `TargetValue` )
          ( `SourceCondition` )
          ( `TargetCondition` )
          ( `Status` )
          ( `CreatedBy` )
          ( `CreatedAt` )
          ( `LocalChangedBy` )
          ( `LocalLastChangedAt` )
          ( `LastChangedAt` )
      ).

      lv_created_by = ls_mapv-CreatedBy.
      lv_created_at = ls_mapv-CreatedAt.

      LOOP AT lt_control_components INTO DATA(lv_component_name).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update-%control TO FIELD-SYMBOL(<lv_control_value>).
        CHECK <lv_control_value> = cl_abap_behavior_handler=>flag_changed.
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update TO FIELD-SYMBOL(<lv_new_value>).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_mapv TO FIELD-SYMBOL(<lv_old_value>).
        <lv_old_value> = <lv_new_value>.
      ENDLOOP.

      ls_root_to_update-LocalChangedBy = sy-uname.
      GET TIME STAMP FIELD lv_changed_timestamp.
      ls_root_to_update-LastChangedAt = lv_changed_timestamp.
      ls_root_to_update-LocalLastChangedAt = lv_changed_timestamp.
      ls_root_to_update-CreatedBy = lv_created_by.
      ls_root_to_update-CreatedAt = lv_created_at.

      CLEAR lw_mapv.
      lw_mapv-customer_id = ls_root_to_update-CustomerId.
      lw_mapv-rule_id = ls_root_to_update-RuleId.
      lw_mapv-condition_seq = ls_root_to_update-ConditionSeq.
      lw_mapv-target_seq = ls_root_to_update-TargetSeq.
      lw_mapv-value_id = ls_root_to_update-ValueId.
      lw_mapv-valid_from = ls_root_to_update-ValidFrom.
      lw_mapv-valid_to = ls_root_to_update-ValidTo.
      lw_mapv-source_value = ls_root_to_update-SourceValue.
      lw_mapv-target_value = ls_root_to_update-TargetValue.
      lw_mapv-source_condition = ls_root_to_update-SourceCondition.
      lw_mapv-target_condition = ls_root_to_update-TargetCondition.
      lw_mapv-status = ls_root_to_update-Status.
      lw_mapv-created_by = ls_root_to_update-CreatedBy.
      lw_mapv-created_at = ls_root_to_update-CreatedAt.
      lw_mapv-local_changed_by = ls_root_to_update-LocalChangedBy.
      lw_mapv-local_last_changed_at = ls_root_to_update-LocalLastChangedAt.
      lw_mapv-last_changed_at = ls_root_to_update-LastChangedAt.

      DATA(lv_message) = validate( iv_action = cs_action-update is_mapv = ls_mapv ).

      INSERT lw_mapv INTO TABLE mt_root_to_update.
    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

    LOOP AT keys INTO DATA(ls_root_to_delete).
      SELECT SINGLE FROM /zuora001/i_mapv FIELDS *
      WHERE CustomerId = @ls_root_to_delete-CustomerId AND RuleId = @ls_root_to_delete-RuleId AND
            ConditionSeq = @ls_root_to_delete-ConditionSeq AND TargetSeq = @ls_root_to_delete-TargetSeq AND
            ValueId = @ls_root_to_delete-ValueId AND ValidFrom = @ls_root_to_delete-ValidFrom
      INTO @DATA(ls_mapv).

      CLEAR lw_mapv.
      lw_mapv-customer_id = ls_mapv-CustomerId.
      lw_mapv-rule_id = ls_mapv-RuleId.
      lw_mapv-condition_seq = ls_mapv-ConditionSeq.
      lw_mapv-target_seq = ls_mapv-TargetSeq.
      lw_mapv-value_id = ls_mapv-ValueId.
      lw_mapv-valid_from = ls_mapv-ValidFrom.

      DATA(lv_message) = validate( iv_action = cs_action-delete is_mapv = ls_mapv ).

      INSERT CORRESPONDING #( lw_mapv ) INTO TABLE mt_root_to_delete.

    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD validate.
  ENDMETHOD.

  METHOD get_global_authorizations.
    IF requested_authorizations-%update = if_abap_behv=>mk-on.
      result-%update = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_I_MAPV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_I_MAPV IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    INSERT /zuora001/t_mapv FROM TABLE @lhc_mapv=>mt_root_to_create.
    UPDATE /zuora001/t_mapv FROM TABLE @lhc_mapv=>mt_root_to_update.
    DELETE /zuora001/t_mapv FROM TABLE @lhc_mapv=>mt_root_to_delete.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
