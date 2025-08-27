CLASS lhc_R_JE_REVH DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      gt_invoice_h       TYPE STANDARD TABLE OF  /zuora001/t_revh,
      gt_invoice_ret     TYPE STANDARD TABLE OF  /zuora001/t_revr,
      gt_api_log         TYPE STANDARD TABLE OF  /zuora001/t_apic,
      gt_Customer_master TYPE STANDARD TABLE OF /zuora001/i_cust,
      ls_ret             TYPE /zuora001/t_je_r,
      ls_api_call        TYPE /zuora001/t_apic,
      gv_timestamp1      TYPE timestampl,
      gv_timestamp_P     TYPE timestampl,
      gv_id              TYPE sysuuid_x16,
      gv_start_time      TYPE t,
      gv_je_end_time     TYPE t,
      gv_uuid            TYPE string,
      gv_object_key      TYPE string,
      gv_landscape  TYPE /zuora001/t_je_h-land_scape,
      gv_pos             TYPE i,
      gv_customer_id     TYPE /zuora001/decustomerid,
      gv_je_user_name    TYPE /zuora001/t_je_h-username,
      customer_id        TYPE /zuora001/t_je_h-customer_id,
      destination_system TYPE /zuora001/t_je_h-destination_system,
      destination_name   TYPE /zuora001/t_je_h-destination_name,
      gv_invoice         TYPE /zuora001/t_je_h-je_doc_number.


    DATA: lv_URL        TYPE string,
          lv_URL_S4     TYPE string,
          i_name        TYPE string,
          lv_out_string TYPE string.
    DATA:item_GL    TYPE STANDARD TABLE OF  /zuora001/journal_entry_creat9,
         ls_item_gl TYPE  /zuora001/journal_entry_creat9,
         tax        TYPE STANDARD TABLE OF /zuora001/journal_entry_creat9-tax,
         ls_tax_det TYPE /zuora001/journal_entry_creat2.
    DATA: lt_mes TYPE STANDARD TABLE OF char256.
    DATA: lv_tax_code TYPE /zuora001/product_taxation_ch1.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /zuora001/r_je_revh RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /zuora001/r_je_revh.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_revh.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_revh.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_revh RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /zuora001/r_je_revh.

    METHODS rba_Return FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_revh\Return FULL result_requested RESULT result LINK association_links.

    METHODS cba_Return FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_revh\Return.
** Added additional Methods + Types Data
    TYPES: BEGIN OF e_msg,
             message TYPE string,
             inv_no  TYPE /zuora001/t_je_h-je_doc_number,
           END OF e_msg.
    METHODS:

      get_next_id
        RETURNING VALUE(rv_id) TYPE sysuuid_x16
        RAISING   cx_uuid_error ,

      get_next_invoice_id
        RETURNING VALUE(rv_inv_id) TYPE /zuora001/t_je_h-je_doc_number,

      Post_Invoice
        EXPORTING e_msg TYPE e_msg
        RAISING   cx_uuid_error . "string.

ENDCLASS.

CLASS lhc_R_JE_REVH IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    CLEAR:customer_id,destination_name,destination_system,gv_je_user_name,gv_id,gv_uuid .
    GET TIME STAMP FIELD gv_timestamp1.
    CONVERT TIME STAMP gv_timestamp1 TIME ZONE 'UTC' INTO DATE DATA(gv_start_date) TIME DATA(gv_start_time).
*  * Read Entity from UI in table after filling all entries and press CREATE button
    "--Mapping is required for this CORRESPONDING in behavior CDS--DB in BH_Def.
    gt_invoice_h = CORRESPONDING #( entities MAPPING FROM ENTITY ).
    IF gt_invoice_h IS NOT INITIAL.
      TRY.
          gv_id = get_next_id( ).
          gv_uuid  = gv_id.
          gv_uuid = to_upper( gv_uuid ).  " Convert to upper case
        CATCH cx_uuid_error INTO DATA(ls_uuid_error).
          DATA(error_message) = ls_uuid_error->get_text(  ).
          ls_ret-type  = 'E'.
          ls_ret-message =  error_message.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR ls_ret.
      ENDTRY.
      GET TIME STAMP FIELD gv_timestamp1.
      gt_invoice_h[ 1 ]-lastchangedat = gv_timestamp1.
      gt_invoice_h[ 1 ]-lastchangedat = gv_timestamp1.
      gt_invoice_h[ 1 ]-je_uid = gv_id.
      gv_je_user_name = gt_invoice_h[ 1 ]-username.
      customer_id =  gt_invoice_h[ 1 ]-customer_id.
      destination_name = gt_invoice_h[ 1 ]-destination_name.
      destination_system = gt_invoice_h[ 1 ]-destination_system.
*&---------------------------------------------------------------------->
*Capture API Calls Logs
*&---------------------------------------------------------------------->
      ls_api_call-client                = sy-mandt.
      ls_api_call-je_uid               = gv_id.
      ls_api_call-customer_id          = customer_id.
      ls_api_call-je_doc_number        = ''.
      ls_api_call-dsetination_system   = destination_system.
      ls_api_call-destination_name     = destination_name.
      ls_api_call-api_start_date       = gv_timestamp1.
      ls_api_call-execution_time       = ''.
      ls_api_call-api_user_id          = 'AFI_BTP'.
      ls_api_call-number_of_je_line_items = ''.
      ls_api_call-api_status           = ''.
      ls_api_call-status               = ''.
      ls_api_call-created_by = gt_invoice_h[ 1 ]-username.
      ls_api_call-created_at = gv_timestamp1.
      ls_api_call-local_changed_by      = ''.
      ls_api_call-local_last_changed_at = ''.
      ls_api_call-last_changed_at       = ''.
*      MODIFY /zuora001/t_apic FROM @ls_api_call.
*      CLEAR:ls_api_call.
*&---------------------------------------------------------------------->
      mapped = VALUE #(
        /zuora001/r_je_revh  = VALUE #( FOR ls_entity IN entities
                                  (
                                      %cid = ls_entity-%cid
                                      %key = ls_entity-%key
                                      je_uid = gv_uuid
                                      customer_id =  customer_id
                                   ) "For Loop
                                ) "

                     ).
      TRY.
          CALL METHOD post_invoice
            IMPORTING
              e_msg = DATA(lv_message).
          IF lv_message IS NOT INITIAL   .
            gv_invoice   = lv_message-inv_no.
          ELSE.
            gv_invoice  = ''.
          ENDIF.
        CATCH cx_uuid_error INTO DATA(lx_uuid_error).
          error_message = lx_uuid_error->get_text(  ).
          ls_ret-je_uid = gv_uuid.
          ls_ret-customer_id = customer_id.
          ls_ret-destination_name = destination_name.
          ls_ret-type  = 'E'.
          ls_ret-message =  error_message.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR ls_ret.
      ENDTRY.
      GET TIME STAMP FIELD gv_timestamp1.
      CONVERT TIME STAMP gv_timestamp1 TIME ZONE 'UTC' INTO DATE gv_start_date TIME DATA(gv_je_end_time).
      DATA(lv_count) = 1.  " Count the number of entries in GT_INVOICE_I
      ls_api_call-client                = sy-mandt.
      ls_api_call-je_uid               = gv_id.
      ls_api_call-customer_id          = customer_id.
      IF gv_invoice IS INITIAL.
        gv_invoice  = '0000000'.
      ENDIF.
      ls_api_call-je_doc_number        = gv_invoice.
      ls_api_call-dsetination_system   = destination_system.
      ls_api_call-destination_name     = destination_name.
      ls_api_call-api_start_date       = gv_timestamp1.
      ls_api_call-execution_time       = ( gv_je_end_time - gv_start_time ) / 60.
      ls_api_call-number_of_je_line_items = lv_count.
      ls_api_call-api_status           = '201'.
      IF gv_invoice = '0000000'.
        ls_api_call-status               = 'E'.
      ELSE.
        ls_api_call-status               = 'S'.
      ENDIF.
      ls_api_call-created_by = gv_je_user_name.
      GET TIME STAMP FIELD gv_timestamp_P.
      ls_api_call-posting_type = 'R'.
      ls_api_call-created_at = gv_timestamp_P.
      ls_api_call-local_changed_by      = sy-uname.
      ls_api_call-local_last_changed_at = gv_timestamp_P.
      ls_api_call-last_changed_at       = gv_timestamp_P.
      MODIFY /zuora001/t_apic FROM @ls_api_call.
      CLEAR:ls_api_call,lv_count,gv_je_end_time,gv_start_time,gv_je_user_name.
      LOOP AT gt_invoice_h ASSIGNING FIELD-SYMBOL(<fs_hdr>).
        IF <fs_hdr>-je_uid IS NOT INITIAL.
          <fs_hdr>-je_doc_number = gv_invoice.
        ENDIF.
      ENDLOOP.
** Update New Invoice Number in Global Table Invoice-Item
      LOOP AT gt_invoice_ret ASSIGNING FIELD-SYMBOL(<fs_Item>).
        IF <fs_Item>-je_uid IS NOT INITIAL.
          <fs_Item>-je_doc_number = gv_invoice.
          <fs_Item>-customer_id = customer_id.
          <fs_Item>-destination_name = destination_name.
          <fs_Item>-destination_system = destination_system.
        ENDIF.
      ENDLOOP.
      mapped = VALUE #( /zuora001/r_je_revr = VALUE #(
                                  FOR ls_head IN gt_invoice_h
                                  FOR ls_log IN gt_invoice_ret "gt_errors
                                             (
                                                 Je_Uid = gv_id
                                                 JeDocNumber = gv_invoice
                                                 customer_id = customer_id
*                                                message  = ls_log-message
                                              )
                                     )
                       ).
    ENDIF.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Return.
  ENDMETHOD.

  METHOD cba_Return.
** Sending Data back to UI

    mapped = VALUE #(
            /zuora001/r_je_revh  = VALUE #(
                                FOR ls_entity_h IN entities_cba
                                  (
                                      %cid = ls_entity_h-%cid_ref
*                                      %key = ls_entity_h-%key
                                      je_uid = gv_id
                                      customer_id = customer_id
                                      JeDocNumber = gv_invoice
                                  )"
                                ) "
            /zuora001/r_je_revr = VALUE #(
                                 FOR ls_head IN entities_cba
                                   FOR ls_log IN gt_invoice_ret "gt_errors
                                            (
                                                %cid = ls_head-%cid_ref
                                                Je_Uid = gv_id
                                                JeDocNumber = gv_invoice
                                                customer_id = customer_id
*                                                message  = ls_log-message
                                             )
                                    )
                      ).

    CLEAR:gv_id,customer_id.
  ENDMETHOD.

  METHOD get_next_id.
    TRY.
        DATA(lv_new_id) = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
        rv_id = lv_new_id.
      CATCH cx_uuid_error INTO DATA(gs_uuid_error)..
        DATA(error_message) = gs_uuid_error->get_text(  ).
        ls_ret-je_uid = gv_uuid.
        ls_ret-customer_id = customer_id.
        ls_ret-destination_name = destination_name.
        ls_ret-type  = 'E'.
        ls_ret-message =  error_message.
        APPEND ls_ret TO gt_invoice_ret.
        CLEAR ls_ret.
    ENDTRY.
  ENDMETHOD.

  METHOD get_next_invoice_id.

  ENDMETHOD.

  METHOD post_invoice.
    IF gt_invoice_h IS NOT INITIAL.
      DATA(ls_header_check) = VALUE #( gt_invoice_h[ 1 ] OPTIONAL ).
    ENDIF.
*&------------------------------------------------------------------------------->
*& JE Header Validation
    DATA(lo_process_je) = NEW /zuora001/process_je( ).
    DATA(lo_validator) = NEW /zuora001/je_validation( ).
    DATA(lo_process_journal_ecc) = NEW /zuora001/ecc_journal_post( ).
    " Call the validation method
    lo_validator->validate_rev_header( EXPORTING is_header_check = ls_header_check
                                           gv_id =  gv_id
                                        destination_name = destination_name
                                        gv_customer_id = customer_id
                                      IMPORTING gt_invoice_ret  = gt_invoice_ret ).
*&------------------------------------------------------------------------------->
    CLEAR:gv_customer_id.
    IF gt_invoice_ret[] IS INITIAL.
      DATA(ls_fi_header) = VALUE #( gt_invoice_h[ 1 ] OPTIONAL ).

     lo_process_je->get_system_version( EXPORTING customer_id = customer_id
                                                  destination_name = destination_name
                                        CHANGING  landscape = gv_landscape ).
      IF gv_landscape = 'PRI'.
        lo_process_journal_ecc->journal_rev_post_ecc( EXPORTING destination_name  = destination_name
                                                     is_header_check = ls_fi_header
                                                     gv_id =  gv_id
                                                     destination_system = destination_system
                                                     CHANGING
                                                     gt_invoice_h  = gt_invoice_h
                                                     gt_invoice_ret = gt_invoice_ret
                                                     e_msg = e_msg ).

      ELSE.

        TRY.                                     "Sample URL

            CLEAR:i_name .
            i_name = destination_name.
            DATA(lo_destination) = cl_soap_destination_provider=>create_by_cloud_destination(
             i_name       =  i_name
           ).
            DATA(proxy) = NEW /zuora001/co_journal_entry_cre( destination = lo_destination ).
            IF gt_invoice_h IS NOT INITIAL.
              DATA(ls_header) = VALUE #( gt_invoice_h[ 1 ] OPTIONAL ).
            ENDIF.
            " fill request
            DATA(request) = VALUE /zuora001/journal_entry_bulk_c(
           journal_entry_bulk_create_requ = VALUE #( message_header = VALUE #( creation_date_time  = gv_timestamp1 "20240201110011 "'2018-06-05T12:00:00.1234567Z'
                                                                               test_data_indicator = '' ) "Pass 'X'-Document check - no errors: BKPFF $
                      journal_entry_create_request = VALUE #(
                                (
                                   journal_entry = VALUE #(
                                                    original_reference_document_ty  = ls_header-obj_type
                                                    company_code = ls_header-comp_code
                                                    created_by_user = ls_header-username "''
                                                    reversal_reference_document = ls_header-obj_key_r
                                                    document_date = ls_header-doc_date "20220202'
                                                    posting_date = ls_header-pstng_date "'20220202'
                                                    document_reference_id = ls_header-ref_doc_no
                                                    reversal_reason  = ls_header-reason_rev
                                                          )"journal_entry
                                                      )"[ 1 ]
                                                 )"3-journal_entry_create_request[]
                                       )"2-journal_entry_bulk_create_requ
                                )."1-zjournal_entry_bulk_create_req

            proxy->journal_entry_create_request_c(
              EXPORTING
                input = request
              IMPORTING
                output = DATA(response)
            ).
            lt_mes = VALUE #( FOR ls_msg IN response-journal_entry_bulk_create_conf-journal_entry_create_confirmat[ 1 ]-log-item ( ls_msg-note ) ).
            e_msg-message = lt_mes[ 1 ].
            e_msg-inv_no = substring_after( val = e_msg-message sub = 'BKPFF 0'  len = 9 ).
            LOOP AT response-journal_entry_bulk_create_conf-journal_entry_create_confirmat[ 1 ]-log-item INTO DATA(ls_item).
              ls_ret-je_uid = gv_id.
              ls_ret-destination_name = destination_name.
              ls_ret-destination_system = destination_system.
              ls_ret-je_doc_number = e_msg-inv_no.
              ls_ret-res_id = ls_item-type_id+4(2).
              ls_ret-res_number = ls_item-type_id+0(4).
              IF ls_item-severity_code = 1.
                ls_ret-type = 'S'.
                ls_ret-message_v2 = ls_item-note+36(18).
              ELSE.
                ls_ret-type = 'E'.
              ENDIF.
              ls_ret-message = ls_item-note.
              READ TABLE gt_invoice_h ASSIGNING FIELD-SYMBOL(<fs_head>) INDEX 1.
              IF sy-subrc = 0 .
                <fs_head>-obj_key_r = ls_ret-message_v2.
                <fs_head>-obj_key = ls_ret-message_v2.
                <fs_head>-obj_type = 'BKPFF'.
              ENDIF.
              APPEND ls_ret TO gt_invoice_ret.
              CLEAR:ls_ret.
            ENDLOOP.
            " handle response
          CATCH cx_soap_destination_error INTO DATA(soap_destination_error).
            DATA(error_message) = soap_destination_error->get_text(  ).
            e_msg-message = error_message.
            ls_ret-type  = 'E'.
            ls_ret-message =  e_msg-message.
            APPEND ls_ret TO gt_invoice_ret.
            CLEAR ls_ret.
          CATCH cx_ai_system_fault INTO DATA(ai_system_fault).
            error_message = |code: { ai_system_fault->code  } codetext: { ai_system_fault->errortext }|.
            e_msg-message = error_message.
            ls_ret-type  = 'E'.
            ls_ret-message =  e_msg-message.
            APPEND ls_ret TO gt_invoice_ret.
            CLEAR ls_ret.
          CATCH cx_http_dest_provider_error INTO DATA(http_dest_provider_error).
            error_message = http_dest_provider_error->get_text(  ).
            e_msg-message = error_message.
            ls_ret-type  = 'E'.
            ls_ret-message =  e_msg-message.
            APPEND ls_ret TO gt_invoice_ret.
            CLEAR ls_ret.
        ENDTRY.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_JE_REVR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_revr.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_revr.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_revr RESULT result.

    METHODS rba_Documentheader FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_revr\Documentheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_JE_REVR IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Documentheader.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_R_JE_REVH DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_R_JE_REVH IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
** Save Invoice Header Data
    IF NOT lhc_R_JE_REVH=>gt_invoice_h IS INITIAL.
      MODIFY /zuora001/t_revh FROM TABLE @lhc_R_JE_REVH=>gt_invoice_h.
    ENDIF.
** Save Return Structure
    IF lhc_R_JE_REVH=>gt_invoice_ret IS NOT INITIAL.
      MODIFY /zuora001/t_revr FROM TABLE @lhc_R_JE_REVH=>gt_invoice_ret .
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
