CLASS lhc_I_CPBT DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      mt_root_to_create TYPE STANDARD TABLE OF /zuora001/t_cpbt,
      mt_root_to_update TYPE STANDARD TABLE OF /zuora001/t_cpbt,
      mt_root_to_delete TYPE STANDARD TABLE OF /zuora001/t_cpbt.
    DATA : lw_cpbt TYPE /zuora001/t_cpbt.

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
      IMPORTING entities FOR CREATE Cpbt.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Cpbt.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Cpbt.

    METHODS read FOR READ
      IMPORTING keys FOR READ Cpbt RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Cpbt.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Cpbt RESULT result.

    METHODS validate
      IMPORTING
        iv_action         TYPE ty_action
        is_capb           TYPE /zuora001/i_cpbt
      RETURNING
        VALUE(rv_message) TYPE string.

ENDCLASS.

CLASS lhc_I_CPBT IMPLEMENTATION.

  METHOD create.

    DATA : lv_capab_id TYPE /zuora001/t_cpbt-capability_id,
           lv_tstmp    TYPE /zuora001/t_cpbt-created_at.

    LOOP AT entities INTO DATA(ls_root_to_create).
      DATA(lv_message) = validate( iv_action = cs_action-create is_capb = CORRESPONDING /zuora001/i_cpbt( ls_root_to_create ) ).

      IF lv_message IS INITIAL.
        ls_root_to_create-Status = '1'.
        ls_root_to_create-CreatedBy = sy-uname.
        GET TIME STAMP FIELD lv_tstmp.

        ls_root_to_create-CreatedAt = lv_tstmp.
        ls_root_to_create-LocalLastChangedAt = lv_tstmp.

        IF ls_root_to_create-CapabilityId IS INITIAL OR ls_root_to_create-CapabilityId = 0.
          SELECT MAX( capability_id ) FROM /zuora001/t_cpbt WHERE capability_id > 0 INTO @lv_capab_id.
          IF lv_capab_id IS NOT INITIAL.
            lv_capab_id = lv_capab_id + 1.
          ELSE.
            lv_capab_id = 1.
          ENDIF.
          ls_root_to_create-CapabilityId = lv_capab_id.
        ENDIF.

        INSERT CORRESPONDING #( ls_root_to_create ) INTO TABLE mapped-cpbt.

        CLEAR lw_cpbt.
        lw_cpbt-capability_id = ls_root_to_create-CapabilityId.
        lw_cpbt-valid_from = ls_root_to_create-ValidFrom.
        lw_cpbt-valid_to = ls_root_to_create-ValidTo.
        lw_cpbt-capability_name = ls_root_to_create-CapabilityName.
        lw_cpbt-status = ls_root_to_create-Status.
        lw_cpbt-created_by = ls_root_to_create-CreatedBy.
        lw_cpbt-created_at = ls_root_to_create-CreatedAt.
        lw_cpbt-local_last_changed_at = ls_root_to_create-LocalLastChangedAt.

        INSERT CORRESPONDING #( lw_cpbt ) INTO TABLE mt_root_to_create.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.

    DATA : lv_changed_timestamp TYPE /zuora001/t_cpbt-last_changed_at,
           lv_created_by        TYPE /zuora001/t_cpbt-created_by,
           lv_created_at        TYPE /zuora001/t_cpbt-created_at.

    LOOP AT entities INTO DATA(ls_root_to_update).
      SELECT SINGLE FROM /zuora001/i_cpbt FIELDS CapabilityId, ValidFrom, ValidTo, CapabilityName, Status, CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt
      WHERE CapabilityId = @ls_root_to_update-CapabilityId AND ValidFrom = @ls_root_to_update-ValidFrom
      INTO @DATA(ls_capb).

      DATA(lt_control_components) = VALUE string_table(
          ( `CapabilityId` )
          ( `ValidFrom` )
          ( `ValidTo` )
          ( `CapabilityName` )
          ( `Status` )
          ( `CreatedBy` )
          ( `CreatedAt` )
          ( `LocalChangedBy` )
          ( `LocalLastChangedAt` )
          ( `LastChangedAt` )
      ).

      lv_created_by = ls_capb-CreatedBy.
      lv_created_at = ls_capb-CreatedAt.

      LOOP AT lt_control_components INTO DATA(lv_component_name).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update-%control TO FIELD-SYMBOL(<lv_control_value>).
        CHECK <lv_control_value> = cl_abap_behavior_handler=>flag_changed.
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update TO FIELD-SYMBOL(<lv_new_value>).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_capb TO FIELD-SYMBOL(<lv_old_value>).
        <lv_old_value> = <lv_new_value>.
      ENDLOOP.

      ls_root_to_update-LocalChangedBy = sy-uname.
      GET TIME STAMP FIELD lv_changed_timestamp.
      ls_root_to_update-LastChangedAt = lv_changed_timestamp.
      ls_root_to_update-LocalLastChangedAt = lv_changed_timestamp.
      ls_root_to_update-CreatedBy = lv_created_by.
      ls_root_to_update-CreatedAt = lv_created_at.

      CLEAR lw_cpbt.
      lw_cpbt-capability_id = ls_root_to_update-CapabilityId.
      lw_cpbt-valid_from = ls_root_to_update-ValidFrom.
      lw_cpbt-valid_to = ls_root_to_update-ValidTo.
      lw_cpbt-capability_name = ls_root_to_update-CapabilityName.
      lw_cpbt-status = ls_root_to_update-Status.
      lw_cpbt-created_by = ls_root_to_update-CreatedBy.
      lw_cpbt-created_at = ls_root_to_update-CreatedAt.
      lw_cpbt-local_changed_by = ls_root_to_update-LocalChangedBy.
      lw_cpbt-local_last_changed_at = ls_root_to_update-LocalLastChangedAt.
      lw_cpbt-last_changed_at = ls_root_to_update-LastChangedAt.

      DATA(lv_message) = validate( iv_action = cs_action-update is_capb = ls_capb ).

      INSERT lw_cpbt INTO TABLE mt_root_to_update.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.
    LOOP AT keys INTO DATA(ls_root_to_delete).
      SELECT SINGLE FROM /zuora001/i_cpbt FIELDS CapabilityId, ValidFrom, ValidTo, CapabilityName, Status, CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt
      WHERE CapabilityId = @ls_root_to_delete-CapabilityId AND ValidFrom = @ls_root_to_delete-ValidFrom
      INTO @DATA(ls_capb).

      CLEAR lw_cpbt.
      lw_cpbt-capability_id = ls_capb-CapabilityId.
      lw_cpbt-valid_from = ls_capb-ValidFrom.

      DATA(lv_message) = validate( iv_action = cs_action-delete is_capb = ls_capb ).

      INSERT CORRESPONDING #( lw_cpbt ) INTO TABLE mt_root_to_delete.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
    LOOP AT keys INTO DATA(ls_root_to_lock).
      TRY.
          cl_abap_lock_object_factory=>get_instance( iv_name = '/ZUORA001/ECPBT' )->enqueue(
              it_table_mode = VALUE if_abap_lock_object=>tt_table_mode( ( table_name = '/zuora001/i_cpbt' ) )
              it_parameter = VALUE if_abap_lock_object=>tt_parameter(
                  ( name = 'CapabilityId' value = REF #( ls_root_to_lock-CapabilityId ) )
               )
           ).
        CATCH cx_abap_foreign_lock INTO DATA(lx_lock).
          APPEND VALUE #( CapabilityId = ls_root_to_lock-CapabilityId %fail = VALUE #( cause = if_abap_behv=>cause-locked ) ) TO failed-cpbt.
          APPEND VALUE #( CapabilityId = ls_root_to_lock-CapabilityId %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = lx_lock->get_text( ) ) ) TO reported-cpbt.
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

CLASS lsc_I_CPBT DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_I_CPBT IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    INSERT /zuora001/t_cpbt FROM TABLE @lhc_i_cpbt=>mt_root_to_create.
    UPDATE /zuora001/t_cpbt FROM TABLE @lhc_i_cpbt=>mt_root_to_update.
    DELETE /zuora001/t_cpbt FROM TABLE @lhc_i_cpbt=>mt_root_to_delete.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
