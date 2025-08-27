CLASS lhc_Notf DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.
    CLASS-DATA:
      mt_root_to_create TYPE STANDARD TABLE OF /zuora001/t_notf WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_update TYPE STANDARD TABLE OF /zuora001/t_notf WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_delete TYPE STANDARD TABLE OF /zuora001/t_notf WITH NON-UNIQUE DEFAULT KEY.
    DATA : lw_notif TYPE /zuora001/t_notf.

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
      IMPORTING entities FOR CREATE Notf.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Notf.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Notf.

    METHODS read FOR READ
      IMPORTING keys FOR READ Notf RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Notf.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Notf RESULT result.

    METHODS validate
      IMPORTING
        iv_action         TYPE ty_action
        is_notif          TYPE /zuora001/i_notf
      RETURNING
        VALUE(rv_message) TYPE string.

ENDCLASS.

CLASS lhc_Notf IMPLEMENTATION.

  METHOD create.

    DATA : lv_notif_id TYPE /zuora001/t_notf-notification_id,
           lv_tstmp    TYPE /zuora001/t_notf-created_at.

    LOOP AT entities INTO DATA(ls_root_to_create).
      DATA(lv_message) = validate( iv_action = cs_action-create is_notif = CORRESPONDING /zuora001/i_notf( ls_root_to_create ) ).

      IF lv_message IS INITIAL.
        ls_root_to_create-Status = '1'.
        ls_root_to_create-CreatedBy = sy-uname.
        GET TIME STAMP FIELD lv_tstmp.
        ls_root_to_create-CreatedAt = lv_tstmp.
        ls_root_to_create-LocalLastChangedAt = lv_tstmp.

        SELECT MAX( notification_id ) FROM /zuora001/t_notf WHERE notification_id > 0 INTO @lv_notif_id.
        IF lv_notif_id IS NOT INITIAL.
          lv_notif_id = lv_notif_id + 1.
        ELSE.
          lv_notif_id = 1.
        ENDIF.
        ls_root_to_create-NotificationId = lv_notif_id.

        INSERT CORRESPONDING #( ls_root_to_create ) INTO TABLE mapped-notf.

        CLEAR lw_notif.
        lw_notif-notification_id = ls_root_to_create-NotificationId.
        lw_notif-customer_id = ls_root_to_create-CustomerId.
        lw_notif-valid_from = ls_root_to_create-ValidFrom.
        lw_notif-valid_to = ls_root_to_create-ValidTo.
        lw_notif-email_notification = ls_root_to_create-EmailNotification.
        lw_notif-req_failure = ls_root_to_create-ReqFailure.
        lw_notif-req_warnings = ls_root_to_create-ReqWarnings.
        lw_notif-req_success = ls_root_to_create-ReqSuccess.
        lw_notif-status = ls_root_to_create-Status.
        lw_notif-created_by = ls_root_to_create-CreatedBy.
        lw_notif-created_at = ls_root_to_create-CreatedAt.
        lw_notif-local_last_changed_at = ls_root_to_create-LocalLastChangedAt.

        INSERT CORRESPONDING #( lw_notif ) INTO TABLE mt_root_to_create.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.

    DATA : lv_changed_timestamp TYPE /zuora001/t_notf-last_changed_at,
           lv_created_by        TYPE /zuora001/t_cust-created_by,
           lv_created_at        TYPE /zuora001/t_cust-created_at.

    LOOP AT entities INTO DATA(ls_root_to_update).
      SELECT SINGLE FROM /zuora001/i_notf FIELDS CustomerId, NotificationId, ValidFrom, ValidTo, EmailNotification,
                                                 ReqFailure, ReqWarnings, ReqSuccess, Status,
                                                 CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt
      WHERE NotificationId = @ls_root_to_update-NotificationId AND CustomerId = @ls_root_to_update-CustomerId AND
            ValidFrom = @ls_root_to_update-ValidFrom
      INTO @DATA(ls_notif).

      DATA(lt_control_components) = VALUE string_table(
          ( `CustomerId` )
          ( `NotificationId` )
          ( `ValidFrom` )
          ( `ValidTo` )
          ( `EmailNotification` )
          ( `ReqFailure` )
          ( `ReqWarnings` )
          ( `ReqSuccess` )
          ( `Status` )
          ( `CreatedBy` )
          ( `CreatedAt` )
          ( `LocalChangedBy` )
          ( `LocalLastChangedAt` )
          ( `LastChangedAt` )
      ).

      lv_created_by = ls_notif-CreatedBy.
      lv_created_at = ls_notif-CreatedAt.

      LOOP AT lt_control_components INTO DATA(lv_component_name).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update-%control TO FIELD-SYMBOL(<lv_control_value>).
        CHECK <lv_control_value> = cl_abap_behavior_handler=>flag_changed.
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update TO FIELD-SYMBOL(<lv_new_value>).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_notif TO FIELD-SYMBOL(<lv_old_value>).
        <lv_old_value> = <lv_new_value>.
      ENDLOOP.

      ls_root_to_update-LocalChangedBy = sy-uname.
      GET TIME STAMP FIELD lv_changed_timestamp.
      ls_root_to_update-LastChangedAt = lv_changed_timestamp.
      ls_root_to_update-LocalLastChangedAt = lv_changed_timestamp.
      ls_root_to_update-CreatedBy = lv_created_by.
      ls_root_to_update-CreatedAt = lv_created_at.

      CLEAR lw_notif.
      lw_notif-customer_id = ls_root_to_update-CustomerId.
      lw_notif-notification_id = ls_root_to_update-NotificationId.
      lw_notif-valid_from = ls_root_to_update-ValidFrom.
      lw_notif-valid_to = ls_root_to_update-ValidTo.
      lw_notif-email_notification = ls_root_to_update-EmailNotification.
      lw_notif-req_failure = ls_root_to_update-ReqFailure.
      lw_notif-req_warnings = ls_root_to_update-ReqWarnings.
      lw_notif-req_success = ls_root_to_update-ReqSuccess.
      lw_notif-status = ls_root_to_update-Status.
      lw_notif-created_by = ls_root_to_update-CreatedBy.
      lw_notif-created_at = ls_root_to_update-CreatedAt.
      lw_notif-local_changed_by = ls_root_to_update-LocalChangedBy.
      lw_notif-local_last_changed_at = ls_root_to_update-LocalLastChangedAt.
      lw_notif-last_changed_at = ls_root_to_update-LastChangedAt.

      DATA(lv_message) = validate( iv_action = cs_action-update is_notif = ls_notif ).

      INSERT lw_notif INTO TABLE mt_root_to_update.

    ENDLOOP.


  ENDMETHOD.

  METHOD delete.

    LOOP AT keys INTO DATA(ls_root_to_delete).
      SELECT SINGLE FROM /zuora001/i_notf FIELDS *
      WHERE NotificationId = @ls_root_to_delete-NotificationId AND CustomerId = @ls_root_to_delete-CustomerId AND
            ValidFrom = @ls_root_to_delete-ValidFrom
      INTO @DATA(ls_notif).

      CLEAR lw_notif.
      lw_notif-notification_id = ls_notif-NotificationId.
      lw_notif-customer_id = ls_notif-CustomerId.
      lw_notif-valid_from = ls_notif-ValidFrom.
      lw_notif-valid_to = ls_notif-ValidTo.
      lw_notif-email_notification = ls_notif-EmailNotification.
      lw_notif-req_failure = ls_notif-ReqFailure.
      lw_notif-req_warnings = ls_notif-ReqWarnings.
      lw_notif-req_success = ls_notif-ReqSuccess.
      lw_notif-status = ls_notif-Status.
      lw_notif-created_by = ls_notif-CreatedBy.
      lw_notif-created_at = ls_notif-CreatedAt.
      lw_notif-local_changed_by = ls_notif-LocalChangedBy.
      lw_notif-local_last_changed_at = ls_notif-LocalLastChangedAt.
      lw_notif-last_changed_at = ls_notif-LastChangedAt.

      DATA(lv_message) = validate( iv_action = cs_action-delete is_notif = ls_notif ).

      INSERT CORRESPONDING #( lw_notif ) INTO TABLE mt_root_to_delete.


    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
    LOOP AT keys INTO DATA(ls_root_to_lock).
      TRY.
          cl_abap_lock_object_factory=>get_instance( iv_name = '/ZUORA001/ENOTIF' )->enqueue(
              it_table_mode = VALUE if_abap_lock_object=>tt_table_mode( ( table_name = '/zuora001/i_notf' ) )
              it_parameter = VALUE if_abap_lock_object=>tt_parameter(
                  ( name = 'NotificationId' value = REF #( ls_root_to_lock-NotificationId ) )
               )
           ).
        CATCH cx_abap_foreign_lock INTO DATA(lx_lock).
          APPEND VALUE #( NotificationId = ls_root_to_lock-NotificationId %fail = VALUE #( cause = if_abap_behv=>cause-locked ) ) TO failed-notf.
          APPEND VALUE #( NotificationId = ls_root_to_lock-NotificationId %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = lx_lock->get_text( ) ) ) TO reported-notf.
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

CLASS lsc_I_NOTF DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_I_NOTF IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    INSERT /zuora001/t_notf FROM TABLE @lhc_notf=>mt_root_to_create.
    UPDATE /zuora001/t_notf FROM TABLE @lhc_notf=>mt_root_to_update.
    DELETE /zuora001/t_notf FROM TABLE @lhc_notf=>mt_root_to_delete.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
