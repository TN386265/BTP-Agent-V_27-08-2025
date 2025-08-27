CLASS lhc_Dest DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      mt_root_to_create TYPE STANDARD TABLE OF /zuora001/t_dest WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_update TYPE STANDARD TABLE OF /zuora001/t_dest WITH NON-UNIQUE DEFAULT KEY,
      mt_root_to_delete TYPE STANDARD TABLE OF /zuora001/t_dest WITH NON-UNIQUE DEFAULT KEY.
    DATA : lw_dest TYPE /zuora001/t_dest.

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
      IMPORTING entities FOR CREATE Dest.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Dest.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Dest.

    METHODS read FOR READ
      IMPORTING keys FOR READ Dest RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Dest.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Dest RESULT result.

    METHODS validate
      IMPORTING
        iv_action         TYPE ty_action
        is_dest           TYPE /zuora001/i_dest
      RETURNING
        VALUE(rv_message) TYPE string.

ENDCLASS.

CLASS lhc_Dest IMPLEMENTATION.

  METHOD create.
    DATA : lv_dest_id TYPE /zuora001/t_dest-destinationid,
           lv_tstmp   TYPE /zuora001/t_cust-created_at.

    LOOP AT entities INTO DATA(ls_root_to_create).
      DATA(lv_message) = validate( iv_action = cs_action-create is_dest = CORRESPONDING /zuora001/i_dest( ls_root_to_create ) ).

      IF lv_message IS INITIAL.
        ls_root_to_create-Status = '1'.
        ls_root_to_create-CreatedBy = sy-uname.
        GET TIME STAMP FIELD lv_tstmp.

        ls_root_to_create-CreatedAt = lv_tstmp.
        ls_root_to_create-LocalLastChangedAt = lv_tstmp.

        IF ls_root_to_create-Destinationid IS INITIAL OR ls_root_to_create-Destinationid = 0.
          SELECT MAX( destinationid ) FROM /zuora001/t_dest WHERE destinationid > 0 INTO @lv_dest_id.
          IF lv_dest_id IS NOT INITIAL.
            lv_dest_id = lv_dest_id + 1.
          ELSE.
            lv_dest_id = 1.
          ENDIF.
          ls_root_to_create-Destinationid = lv_dest_id.
        ENDIF.

        INSERT CORRESPONDING #( ls_root_to_create ) INTO TABLE mapped-dest.

        CLEAR lw_dest.
        lw_dest-customer_id = ls_root_to_create-CustomerId.
        lw_dest-destinationid = ls_root_to_create-Destinationid.
        lw_dest-valid_from = ls_root_to_create-ValidFrom.
        lw_dest-valid_to = ls_root_to_create-ValidTo.
        lw_dest-destination_name = ls_root_to_create-DestinationName.
        lw_dest-description = ls_root_to_create-Description.
        lw_dest-capability_id = ls_root_to_create-CapabilityId.
        lw_dest-dest_usrl = ls_root_to_create-DestUsrl.
        lw_dest-dest_type = ls_root_to_create-DestType.
        lw_dest-proxy_type = ls_root_to_create-ProxyType.
        lw_dest-auth_type = ls_root_to_create-AuthType.
        lw_dest-auth_user = ls_root_to_create-AuthUser.
        lw_dest-auth_pwd = ls_root_to_create-AuthPwd.
        lw_dest-system_id = ls_root_to_create-SystemId.
        lw_dest-land_scape = ls_root_to_create-LandScape.
        lw_dest-status = ls_root_to_create-Status.
        lw_dest-created_by = ls_root_to_create-CreatedBy.
        lw_dest-created_at = ls_root_to_create-CreatedAt.
        lw_dest-local_last_changed_at = ls_root_to_create-LocalLastChangedAt.

        INSERT CORRESPONDING #( lw_dest ) INTO TABLE mt_root_to_create.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA : lv_changed_timestamp TYPE /zuora001/t_dest-last_changed_at,
           lv_created_by        TYPE /zuora001/t_dest-created_by,
           lv_created_at        TYPE /zuora001/t_dest-created_at.

    LOOP AT entities INTO DATA(ls_root_to_update).
      SELECT SINGLE FROM /zuora001/i_dest FIELDS CustomerId, Destinationid, ValidFrom, ValidTo, DestinationName, Description, CapabilityId,
                                                 DestUsrl, DestType, ProxyType, AuthType, AuthUser, AuthPwd, SystemId, LandScape,
                                                 Status, CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt,
                                                 CreatedUserDescription, ChangedUserDescription
      WHERE CustomerId = @ls_root_to_update-CustomerId AND Destinationid = @ls_root_to_update-Destinationid AND
            ValidFrom = @ls_root_to_update-ValidFrom
      INTO @DATA(ls_dest).

      DATA(lt_control_components) = VALUE string_table(
          ( `CustomerId` )
          ( `Destinationid` )
          ( `ValidFrom` )
          ( `ValidTo` )
          ( `DestinationName` )
          ( `Description` )
          ( `CapabilityId` )
          ( `DestUsrl` )
          ( `DestType` )
          ( `ProxyType` )
          ( `AuthType` )
          ( `AuthUser` )
          ( `AuthPwd` )
          ( `SystemId` )
          ( `LandScape` )
          ( `Status` )
          ( `CreatedBy` )
          ( `CreatedAt` )
          ( `LocalChangedBy` )
          ( `LocalLastChangedAt` )
          ( `LastChangedAt` )
      ).

      lv_created_by = ls_dest-CreatedBy.
      lv_created_at = ls_dest-CreatedAt.

      LOOP AT lt_control_components INTO DATA(lv_component_name).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update-%control TO FIELD-SYMBOL(<lv_control_value>).
        CHECK <lv_control_value> = cl_abap_behavior_handler=>flag_changed.
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_root_to_update TO FIELD-SYMBOL(<lv_new_value>).
        ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_dest TO FIELD-SYMBOL(<lv_old_value>).
        <lv_old_value> = <lv_new_value>.
      ENDLOOP.

      ls_root_to_update-LocalChangedBy = sy-uname.
      GET TIME STAMP FIELD lv_changed_timestamp.
      ls_root_to_update-LastChangedAt = lv_changed_timestamp.
      ls_root_to_update-LocalLastChangedAt = lv_changed_timestamp.
      ls_root_to_update-CreatedBy = lv_created_by.
      ls_root_to_update-CreatedAt = lv_created_at.

      CLEAR lw_dest.
      lw_dest-customer_id = ls_root_to_update-CustomerId.
      lw_dest-destinationid = ls_root_to_update-Destinationid.
      lw_dest-valid_from = ls_root_to_update-ValidFrom.
      lw_dest-valid_to = ls_root_to_update-ValidTo.
      lw_dest-destination_name = ls_root_to_update-DestinationName.
      lw_dest-description = ls_root_to_update-Description.
      lw_dest-capability_id = ls_root_to_update-CapabilityId.
      lw_dest-dest_usrl = ls_root_to_update-DestUsrl.
      lw_dest-dest_type = ls_root_to_update-DestType.
      lw_dest-proxy_type = ls_root_to_update-ProxyType.
      lw_dest-auth_type = ls_root_to_update-AuthType.
      lw_dest-auth_user = ls_root_to_update-AuthUser.
      lw_dest-auth_pwd = ls_root_to_update-AuthPwd.
      lw_dest-system_id = ls_root_to_update-SystemId.
      lw_dest-land_scape = ls_root_to_update-LandScape.
      lw_dest-status = ls_root_to_update-Status.
      lw_dest-created_by = ls_root_to_update-CreatedBy.
      lw_dest-created_at = ls_root_to_update-CreatedAt.
      lw_dest-local_changed_by = ls_root_to_update-LocalChangedBy.
      lw_dest-local_last_changed_at = ls_root_to_update-LocalLastChangedAt.
      lw_dest-last_changed_at = ls_root_to_update-LastChangedAt.

      DATA(lv_message) = validate( iv_action = cs_action-update is_dest = ls_dest ).

      INSERT lw_dest INTO TABLE mt_root_to_update.

    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys INTO DATA(ls_root_to_delete).
      SELECT SINGLE FROM /zuora001/i_dest FIELDS CustomerId, Destinationid, ValidFrom, ValidTo, DestinationName, Description, CapabilityId,
                                                 DestUsrl, DestType, ProxyType, AuthType, AuthUser, AuthPwd, SystemId, LandScape,
                                                 Status, CreatedBy, CreatedAt, LocalChangedBy, LocalLastChangedAt, LastChangedAt,
                                                 CreatedUserDescription, ChangedUserDescription
      WHERE CustomerId = @ls_root_to_delete-CustomerId AND Destinationid = @ls_root_to_delete-Destinationid AND
            ValidFrom = @ls_root_to_delete-ValidFrom
      INTO @DATA(ls_dest).

      CLEAR lw_dest.
      lw_dest-customer_id = ls_dest-CustomerId.
      lw_dest-destinationid = ls_dest-Destinationid.
      lw_dest-valid_from = ls_dest-ValidFrom.

      DATA(lv_message) = validate( iv_action = cs_action-delete is_dest = ls_dest ).

      INSERT CORRESPONDING #( lw_dest ) INTO TABLE mt_root_to_delete.

    ENDLOOP.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
    LOOP AT keys INTO DATA(ls_root_to_lock).
      TRY.
          cl_abap_lock_object_factory=>get_instance( iv_name = '/ZUORA001/EDEST' )->enqueue(
              it_table_mode = VALUE if_abap_lock_object=>tt_table_mode( ( table_name = '/zuora001/i_dest' ) )
              it_parameter = VALUE if_abap_lock_object=>tt_parameter(
                  ( name = 'Destinationid' value = REF #( ls_root_to_lock-Destinationid ) )
               )
           ).
        CATCH cx_abap_foreign_lock INTO DATA(lx_lock).
          APPEND VALUE #( Destinationid = ls_root_to_lock-Destinationid %fail = VALUE #( cause = if_abap_behv=>cause-locked ) ) TO failed-dest.
          APPEND VALUE #( Destinationid = ls_root_to_lock-Destinationid %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = lx_lock->get_text( ) ) ) TO reported-dest.
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

CLASS lsc_I_DEST DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_I_DEST IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    INSERT /zuora001/t_dest FROM TABLE @lhc_dest=>mt_root_to_create.
    UPDATE /zuora001/t_dest FROM TABLE @lhc_dest=>mt_root_to_update.
    DELETE /zuora001/t_dest FROM TABLE @lhc_dest=>mt_root_to_delete.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
