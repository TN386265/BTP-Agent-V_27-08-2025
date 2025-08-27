CLASS lhc_Cust DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      mt_root_to_create TYPE STANDARD TABLE OF /zuora001/t_cust WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_update TYPE STANDARD TABLE OF /zuora001/t_cust WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_delete TYPE STANDARD TABLE OF /zuora001/t_cust WITH NON-UNIQUE DEFAULT KEY.
    DATA : lw_cust TYPE /zuora001/t_cust.

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
      IMPORTING entities FOR CREATE Cust.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Cust.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Cust.

    METHODS read FOR READ
      IMPORTING keys FOR READ Cust RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Cust.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Cust RESULT result.

    METHODS validate
      IMPORTING
        iv_action         TYPE ty_action
        is_cust           TYPE /zuora001/i_cust
      RETURNING
        VALUE(rv_message) TYPE string.

ENDCLASS.

CLASS lhc_Cust IMPLEMENTATION.

  METHOD create.

    DATA : lv_tstmp   TYPE /zuora001/t_cust-created_at.
*           lv_cust_id TYPE /zuora001/t_cust-customer_id,

    LOOP AT entities INTO DATA(ls_root_to_create).
      DATA(lv_message) = validate( iv_action = cs_action-create is_cust = CORRESPONDING /zuora001/i_cust( ls_root_to_create ) ).

      IF lv_message IS INITIAL.
*        ls_root_to_create-Status = '1'.
        ls_root_to_create-CreatedBy = sy-uname.
        GET TIME STAMP FIELD lv_tstmp.

        ls_root_to_create-CreatedAt = lv_tstmp.
        ls_root_to_create-LocalLastChangedAt = lv_tstmp.

*        SELECT MAX( customer_id ) FROM /zuora001/t_cust INTO @lv_cust_id.
*        IF lv_cust_id IS NOT INITIAL.
*          lv_cust_id = lv_cust_id + 1.
*        ELSE.
*          lv_cust_id = 1.
*        ENDIF.
*        ls_root_to_create-CustomerId = lv_cust_id.

        INSERT CORRESPONDING #( ls_root_to_create ) INTO TABLE mapped-cust.

        CLEAR lw_cust.
        lw_cust-customer_id = ls_root_to_create-CustomerId.
        lw_cust-valid_from = ls_root_to_create-ValidFrom.
        lw_cust-valid_to = ls_root_to_create-ValidTo.
        lw_cust-customer_name = ls_root_to_create-CustomerName.
        lw_cust-activated_date = ls_root_to_create-ActivatedDate.
        lw_cust-expiry_date = ls_root_to_create-ExpiryDate.
        lw_cust-active = ls_root_to_create-Active.
        lw_cust-status = ls_root_to_create-Status.
        lw_cust-created_by = ls_root_to_create-CreatedBy.
        lw_cust-created_at = ls_root_to_create-CreatedAt.
        lw_cust-local_last_changed_at = ls_root_to_create-LocalLastChangedAt.

        INSERT CORRESPONDING #( lw_cust ) INTO TABLE mt_root_to_create.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.

    DATA : lv_changed_timestamp TYPE /zuora001/t_cust-last_changed_at,
           lv_created_by        TYPE /zuora001/t_cust-created_by,
           lv_created_at        TYPE /zuora001/t_cust-created_at.

    LOOP AT entities INTO DATA(ls_root_to_update).
      SELECT SINGLE FROM /zuora001/i_cust FIELDS CustomerId, ValidFrom, ValidTo, CustomerName, ActivatedDate, ExpiryDate,
                                                 Active, Status, CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt,
                                                 CreatedUserDescription, ChangedUserDescription
      WHERE CustomerId = @ls_root_to_update-CustomerId AND ValidFrom = @ls_root_to_update-ValidFrom
      INTO @DATA(ls_cust).

      DATA(lt_control_components) = VALUE string_table(
          ( `CustomerId` )
          ( `ValidFrom` )
          ( `ValidTo` )
          ( `CustomerName` )
          ( `ActivatedDate` )
          ( `ExpiryDate` )
          ( `Active` )
          ( `Status` )
          ( `CreatedBy` )
          ( `CreatedAt` )
          ( `LocalChangedBy` )
          ( `LocalLastChangedAt` )
          ( `LastChangedAt` )
      ).

      lv_created_by = ls_cust-CreatedBy.
      lv_created_at = ls_cust-CreatedAt.

      LOOP AT lt_control_components INTO DATA(lv_component_name).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update-%control TO FIELD-SYMBOL(<lv_control_value>).
        CHECK <lv_control_value> = cl_abap_behavior_handler=>flag_changed.
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update TO FIELD-SYMBOL(<lv_new_value>).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_cust TO FIELD-SYMBOL(<lv_old_value>).
        <lv_old_value> = <lv_new_value>.
      ENDLOOP.

      ls_root_to_update-LocalChangedBy = sy-uname.
      GET TIME STAMP FIELD lv_changed_timestamp.
      ls_root_to_update-LastChangedAt = lv_changed_timestamp.
      ls_root_to_update-LocalLastChangedAt = lv_changed_timestamp.
      ls_root_to_update-CreatedBy = lv_created_by.
      ls_root_to_update-CreatedAt = lv_created_at.

      CLEAR lw_cust.
      lw_cust-customer_id = ls_root_to_update-CustomerId.
      lw_cust-valid_from = ls_root_to_update-ValidFrom.
      lw_cust-valid_to = ls_root_to_update-ValidTo.
      lw_cust-customer_name = ls_root_to_update-CustomerName.
      lw_cust-activated_date = ls_root_to_update-ActivatedDate.
      lw_cust-expiry_date = ls_root_to_update-ExpiryDate.
      lw_cust-active = ls_root_to_update-Active.
      lw_cust-status = ls_root_to_update-Status.
      lw_cust-created_by = ls_root_to_update-CreatedBy.
      lw_cust-created_at = ls_root_to_update-CreatedAt.
      lw_cust-local_changed_by = ls_root_to_update-LocalChangedBy.
      lw_cust-local_last_changed_at = ls_root_to_update-LocalLastChangedAt.
      lw_cust-last_changed_at = ls_root_to_update-LastChangedAt.

      DATA(lv_message) = validate( iv_action = cs_action-update is_cust = ls_cust ).

      INSERT lw_cust INTO TABLE mt_root_to_update.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

    LOOP AT keys INTO DATA(ls_root_to_delete).
      SELECT SINGLE FROM /zuora001/i_cust FIELDS CustomerId, ValidFrom, ValidTo, CustomerName, ActivatedDate, ExpiryDate,
                                                 Active, Status, CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt,
                                                 CreatedUserDescription, ChangedUserDescription
      WHERE CustomerId = @ls_root_to_delete-CustomerId AND ValidFrom = @ls_root_to_delete-ValidFrom
      INTO @DATA(ls_cust).

      CLEAR lw_cust.
      lw_cust-customer_id = ls_cust-CustomerId.
      lw_cust-valid_from = ls_cust-ValidFrom.

      DATA(lv_message) = validate( iv_action = cs_action-delete is_cust = ls_cust ).

      INSERT CORRESPONDING #( lw_cust ) INTO TABLE mt_root_to_delete.

    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
    LOOP AT keys INTO DATA(ls_root_to_lock).
      TRY.
          cl_abap_lock_object_factory=>get_instance( iv_name = '/ZUORA001/ECUST' )->enqueue(
              it_table_mode = VALUE if_abap_lock_object=>tt_table_mode( ( table_name = '/zuora001/i_cust' ) )
              it_parameter = VALUE if_abap_lock_object=>tt_parameter(
                  ( name = 'CustomerId' value = REF #( ls_root_to_lock-CustomerId ) )
               )
           ).
        CATCH cx_abap_foreign_lock INTO DATA(lx_lock).
          APPEND VALUE #( CustomerId = ls_root_to_lock-CustomerId %fail = VALUE #( cause = if_abap_behv=>cause-locked ) ) TO failed-cust.
          APPEND VALUE #( CustomerId = ls_root_to_lock-CustomerId %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = lx_lock->get_text( ) ) ) TO reported-cust.
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
    ELSEIF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ELSEIF requested_authorizations-%delete = if_abap_behv=>mk-on.
      result-%delete = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_I_CUST DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_I_CUST IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    INSERT /zuora001/t_cust FROM TABLE @lhc_cust=>mt_root_to_create.
    UPDATE /zuora001/t_cust FROM TABLE @lhc_cust=>mt_root_to_update.
    DELETE /zuora001/t_cust FROM TABLE @lhc_cust=>mt_root_to_delete.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
