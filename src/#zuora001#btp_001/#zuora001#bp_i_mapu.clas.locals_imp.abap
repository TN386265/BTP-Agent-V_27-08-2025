CLASS lhc_Mapu DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      mt_root_to_create TYPE STANDARD TABLE OF /zuora001/t_mapu WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_update TYPE STANDARD TABLE OF /zuora001/t_mapu WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_delete TYPE STANDARD TABLE OF /zuora001/t_mapu WITH NON-UNIQUE DEFAULT KEY.
    DATA : lw_mapu TYPE /zuora001/t_mapu.

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
      IMPORTING entities FOR CREATE Mapu.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Mapu.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Mapu.

    METHODS read FOR READ
      IMPORTING keys FOR READ Mapu RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Mapu.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Mapu RESULT result.

    METHODS validate
      IMPORTING
        iv_action         TYPE ty_action
        is_mapu           TYPE /zuora001/i_mapu
      RETURNING
        VALUE(rv_message) TYPE string.

ENDCLASS.

CLASS lhc_Mapu IMPLEMENTATION.

  METHOD create.
    DATA : lv_tstmp    TYPE /zuora001/t_mapu-created_at.

    LOOP AT entities INTO DATA(ls_root_to_create).
      DATA(lv_message) = validate( iv_action = cs_action-create is_mapu = CORRESPONDING /zuora001/i_mapu( ls_root_to_create ) ).

      IF lv_message IS INITIAL.
*        ls_root_to_create-Status = '1'.
        ls_root_to_create-CreatedBy = sy-uname.
        GET TIME STAMP FIELD lv_tstmp.

        ls_root_to_create-CreatedAt = lv_tstmp.
        ls_root_to_create-LocalLastChangedAt = lv_tstmp.


        INSERT CORRESPONDING #( ls_root_to_create ) INTO TABLE mapped-mapu.

        CLEAR lw_mapu.
        lw_mapu-customer_id = ls_root_to_create-CustomerId.
        lw_mapu-rule_id = ls_root_to_create-RuleId.
        lw_mapu-source_data = ls_root_to_create-SourceData.
        lw_mapu-target_data = ls_root_to_create-TargetData.
        lw_mapu-status = ls_root_to_create-Status.
        lw_mapu-created_by = ls_root_to_create-CreatedBy.
        lw_mapu-created_at = ls_root_to_create-CreatedAt.
        lw_mapu-local_last_changed_at = ls_root_to_create-LocalLastChangedAt.

        INSERT CORRESPONDING #( lw_mapu ) INTO TABLE mt_root_to_create.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA : lv_changed_timestamp TYPE /zuora001/t_mapu-last_changed_at,
           lv_created_by        TYPE /zuora001/t_mapu-created_by,
           lv_created_at        TYPE /zuora001/t_mapu-created_at.

    LOOP AT entities INTO DATA(ls_root_to_update).
      SELECT SINGLE FROM /zuora001/i_mapu FIELDS CustomerId, RuleId, SourceData, TargetData, Status,
                                                 CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt
      WHERE CustomerId = @ls_root_to_update-CustomerId AND RuleId = @ls_root_to_update-RuleId
      INTO @DATA(ls_mapu).

      DATA(lt_control_components) = VALUE string_table(
          ( `CustomerId` )
          ( `RuleId` )
          ( `SourceData` )
          ( `TargetData` )
          ( `Status` )
          ( `CreatedBy` )
          ( `CreatedAt` )
          ( `LocalChangedBy` )
          ( `LocalLastChangedAt` )
          ( `LastChangedAt` )
      ).

      lv_created_by = ls_mapu-CreatedBy.
      lv_created_at = ls_mapu-CreatedAt.

      LOOP AT lt_control_components INTO DATA(lv_component_name).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update-%control TO FIELD-SYMBOL(<lv_control_value>).
        CHECK <lv_control_value> = cl_abap_behavior_handler=>flag_changed.
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update TO FIELD-SYMBOL(<lv_new_value>).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_mapu TO FIELD-SYMBOL(<lv_old_value>).
        <lv_old_value> = <lv_new_value>.
      ENDLOOP.

      ls_root_to_update-LocalChangedBy = sy-uname.
      GET TIME STAMP FIELD lv_changed_timestamp.
      ls_root_to_update-LastChangedAt = lv_changed_timestamp.
      ls_root_to_update-LocalLastChangedAt = lv_changed_timestamp.
      ls_root_to_update-CreatedBy = lv_created_by.
      ls_root_to_update-CreatedAt = lv_created_at.

      CLEAR lw_mapu.
      lw_mapu-customer_id = ls_root_to_update-CustomerId.
      lw_mapu-rule_id = ls_root_to_update-RuleId.
      lw_mapu-source_data = ls_root_to_update-SourceData.
      lw_mapu-target_data = ls_root_to_update-TargetData.
      lw_mapu-status = ls_root_to_update-Status.
      lw_mapu-created_by = ls_root_to_update-CreatedBy.
      lw_mapu-created_at = ls_root_to_update-CreatedAt.
      lw_mapu-local_changed_by = ls_root_to_update-LocalChangedBy.
      lw_mapu-local_last_changed_at = ls_root_to_update-LocalLastChangedAt.
      lw_mapu-last_changed_at = ls_root_to_update-LastChangedAt.

      DATA(lv_message) = validate( iv_action = cs_action-update is_mapu = ls_mapu ).

      INSERT lw_mapu INTO TABLE mt_root_to_update.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys INTO DATA(ls_root_to_delete).
      SELECT SINGLE FROM /zuora001/i_mapu FIELDS CustomerId, RuleId, SourceData, TargetData, Status,
                                                 CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt
      WHERE CustomerId = @ls_root_to_delete-CustomerId AND RuleId = @ls_root_to_delete-RuleId
      INTO @DATA(ls_mapu).

      CLEAR lw_mapu.
      lw_mapu-customer_id = ls_mapu-CustomerId.
      lw_mapu-rule_id = ls_mapu-RuleId.

      DATA(lv_message) = validate( iv_action = cs_action-delete is_mapu = ls_mapu ).

      INSERT CORRESPONDING #( lw_mapu ) INTO TABLE mt_root_to_delete.

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

CLASS lsc_I_MAPU DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_I_MAPU IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    INSERT /zuora001/t_mapu FROM TABLE @lhc_mapu=>mt_root_to_create.
    UPDATE /zuora001/t_mapu FROM TABLE @lhc_mapu=>mt_root_to_update.
    DELETE /zuora001/t_mapu FROM TABLE @lhc_mapu=>mt_root_to_delete.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
