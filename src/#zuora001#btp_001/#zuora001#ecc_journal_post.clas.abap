CLASS /zuora001/ecc_journal_post DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES: BEGIN OF e_msg,
             message TYPE string,
             inv_no  TYPE /zuora001/t_je_h-je_doc_number,
           END OF e_msg.

    DATA: accountgl         TYPE STANDARD TABLE OF  /zuora001/je_eccbapiacgl09,
          accountpayable    TYPE STANDARD TABLE OF /zuora001/je_eccbapiacap09,
          accountreceivable TYPE STANDARD TABLE OF /zuora001/je_eccbapiacar09,
          accounttax        TYPE STANDARD TABLE OF /zuora001/je_eccBAPIACTX09,
          accountwt         TYPE STANDARD TABLE OF /zuora001/je_ecctable_of_bapia,
          contractheader    TYPE  /zuora001/je_eccbapiaccahd,
          contractitem      TYPE STANDARD TABLE OF /zuora001/je_ecctable_of_bapi9,
          criteria          TYPE STANDARD TABLE OF /zuora001/je_ecctable_of_bapi5,
          currencyamount    TYPE STANDARD TABLE OF /zuora001/je_eccbapiaccr09,
          customercpd       TYPE STANDARD TABLE OF /zuora001/je_eccbapiacpa09,
          documentheader    TYPE  /zuora001/je_eccbapiache09,
          extension1        TYPE STANDARD TABLE OF /zuora001/je_ecctable_of_bapi7,
          extension2        TYPE STANDARD TABLE OF /zuora001/je_ecctable_of_bapip,
          paymentcard       TYPE STANDARD TABLE OF /zuora001/je_ecctable_of_bapi3,
          realestate        TYPE STANDARD TABLE OF /zuora001/je_ecctable_of_bapi2,
          return            TYPE STANDARD TABLE OF /zuora001/je_eccbapiret2,
          reversal          TYPE /zuora001/ecc_revbapiacrev,
          valuefield        TYPE STANDARD TABLE OF /zuora001/je_ecctable_of_bapi4.

    CONSTANTS:gv_trans_curr  TYPE /zuora001/t_je_C-currency VALUE '00',
              gv_local_CURR  TYPE /zuora001/t_je_C-currency VALUE '10',
              gv_global_curr TYPE /zuora001/t_je_C-currency VALUE '30'.

    DATA:ls_ret              TYPE /zuora001/t_je_r,
         gv_customer_id      TYPE /zuora001/decustomerid,
         ls_return           TYPE /zuora001/t_je_r,
         i_name              TYPE string,
         gv_id               TYPE sysuuid_x16,
         customer_id         TYPE /zuora001/t_je_h-customer_id,
         destination_system  TYPE /zuora001/t_je_h-destination_system,
         destination_name    TYPE /zuora001/t_je_h-destination_name,
         gv_destination_name TYPE /zuora001/t_dest-destination_name.

    DATA:gt_Customer_master TYPE STANDARD TABLE OF /zuora001/i_cust,
         gt_dest_master     TYPE STANDARD TABLE OF /zuora001/i_dest,
         gt_VALUE_MAPPING   TYPE STANDARD TABLE OF /zuora001/c_je_mapc.

    TYPES:gt_invoice_return TYPE STANDARD TABLE OF  /zuora001/t_je_r,
          gt_invoice_ar     TYPE STANDARD TABLE OF  /zuora001/t_je_z,
          gt_invoice_i      TYPE STANDARD TABLE OF  /zuora001/t_je_i,
          gt_invoice_c      TYPE STANDARD TABLE OF  /zuora001/t_je_c,
          gt_invoice_ap     TYPE STANDARD TABLE OF  /zuora001/t_je_v,
          gt_invoice_h      TYPE STANDARD TABLE OF  /zuora001/t_je_h,
          gt_invoice_rev_h      TYPE STANDARD TABLE OF  /zuora001/t_revh,
          gt_item_record    TYPE STANDARD TABLE OF /zuora001/t_je_i,
          gt_ACCOUNTTAX      TYPE STANDARD TABLE OF  /zuora001/t_JE_T.

    DATA: ls_item_ar TYPE  /zuora001/journal_entry_crea13,
          ls_item_ap TYPE  /zuora001/journal_entry_crea16,
          ls_item_gl TYPE  /zuora001/journal_entry_creat9.

    METHODS journal_post_ecc
      IMPORTING REFERENCE(is_header_check) TYPE  /zuora001/t_je_h
                VALUE(destination_name)    TYPE /zuora001/t_je_h-destination_name
                VALUE(destination_system)  TYPE /zuora001/t_je_h-destination_system OPTIONAL
                VALUE(gv_id)               TYPE sysuuid_x16
      CHANGING  REFERENCE(gt_invoice_i)    TYPE gt_invoice_i
                REFERENCE(gt_invoice_c)    TYPE gt_invoice_c
                REFERENCE(gt_invoice_ar)   TYPE gt_invoice_ar
                REFERENCE(gt_invoice_ap)   TYPE gt_invoice_ap
                REFERENCE(gt_invoice_h)    TYPE gt_invoice_h
                REFERENCE(gt_invoice_ret)  TYPE gt_invoice_return
                REFERENCE(gt_ACCOUNTTAX)   TYPE gt_ACCOUNTTAX
                REFERENCE(e_msg)           TYPE e_msg OPTIONAL.

    METHODS journal_rev_post_ecc
      IMPORTING REFERENCE(is_header_check) TYPE  /zuora001/t_revh
                VALUE(destination_name)    TYPE /zuora001/t_revh-destination_name
                VALUE(destination_system)  TYPE /zuora001/t_revh-destination_system OPTIONAL
                VALUE(gv_id)               TYPE sysuuid_x16
      CHANGING
                REFERENCE(gt_invoice_h)    TYPE gt_invoice_rev_h
                REFERENCE(gt_invoice_ret)  TYPE gt_invoice_return
                REFERENCE(e_msg)           TYPE e_msg OPTIONAL
      .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/ECC_JOURNAL_POST IMPLEMENTATION.


  METHOD journal_post_ecc.
    documentheader = CORRESPONDING #( is_header_check ).
    documentheader-pstng_date = |{ documentheader-pstng_date+0(4) }-{ documentheader-pstng_date+4(2) }-{ documentheader-pstng_date+6(2) }|.
    documentheader-doc_date = |{ documentheader-doc_date+0(4) }-{ documentheader-doc_date+4(2) }-{ documentheader-doc_date+6(2) }|.
    documentheader-vatdate = |{ documentheader-vatdate+0(4) }-{ documentheader-vatdate+4(2) }-{ documentheader-vatdate+6(2) }|.
    documentheader-trans_date = |{ documentheader-trans_date+0(4) }-{ documentheader-trans_date+4(2) }-{ documentheader-trans_date+6(2) }|.
    documentheader-invoice_rec_date = |{ documentheader-invoice_rec_date+0(4) }-{ documentheader-invoice_rec_date+4(2) }-{ documentheader-invoice_rec_date+6(2) }|.
    accountgl = CORRESPONDING #( gt_invoice_i ).
    LOOP AT accountgl ASSIGNING FIELD-SYMBOL(<ls_item>).
      <ls_item>-pstng_date = |{ <ls_item>-pstng_date+0(4) }-{ <ls_item>-pstng_date+4(2) }-{ <ls_item>-pstng_date+6(2) }|.
      <ls_item>-value_date = |{ <ls_item>-value_date+0(4) }-{ <ls_item>-value_date+4(2) }-{ <ls_item>-value_date+6(2) }|.
      <ls_item>-asval_date = |{ <ls_item>-asval_date+0(4) }-{ <ls_item>-asval_date+4(2) }-{ <ls_item>-asval_date+6(2) }|.
      <ls_item>-billing_period_start_date = |{ <ls_item>-billing_period_start_date+0(4) }-{ <ls_item>-billing_period_start_date+4(2) }-{ <ls_item>-billing_period_start_date+6(2) }|.
      <ls_item>-BILLING_PERIOD_end_DATE = |{ <ls_item>-BILLING_PERIOD_end_DATE+0(4) }-{ <ls_item>-BILLING_PERIOD_end_DATE+4(2) }-{ <ls_item>-BILLING_PERIOD_end_DATE+6(2) }|.
    ENDLOOP.
    currencyamount = CORRESPONDING #( gt_invoice_c ).
    accountreceivable = CORRESPONDING #( gt_invoice_ar ).
    accountpayable = CORRESPONDING #( gt_invoice_ap ).
    accounttax = CORRESPONDING #( gt_accounttax ).
    return = CORRESPONDING #( gt_invoice_ret ).
    LOOP AT accountreceivable ASSIGNING FIELD-SYMBOL(<fs_ar>).
      <fs_ar>-bline_date = |{ <fs_ar>-bline_date+0(4) }-{ <fs_ar>-bline_date+4(2) }-{ <fs_ar>-bline_date+6(2) }|.
    ENDLOOP.

    LOOP AT accountpayable ASSIGNING FIELD-SYMBOL(<fs_ap>).
      <fs_ap>-bline_date = |{ <fs_ap>-bline_date+0(4) }-{ <fs_ap>-bline_date+4(2) }-{ <fs_ap>-bline_date+6(2) }|.
      <fs_ap>-tax_date = |{ <fs_ap>-tax_date+0(4) }-{ <fs_ap>-tax_date+4(2) }-{ <fs_ap>-tax_date+6(2) }|.
    ENDLOOP.

    LOOP AT accounttax ASSIGNING FIELD-SYMBOL(<fs_tax>).
   <fs_tax>-tax_date = |{ <fs_tax>-tax_date+0(4) }-{ <fs_tax>-tax_date+4(2) }-{ <fs_tax>-tax_date+6(2) }|.
   ENDLOOP.


    TRY.
        CLEAR:i_name .
        i_name = destination_name.
        DATA(lo_destination) = cl_soap_destination_provider=>create_by_cloud_destination(
         i_name       =  i_name
       ).
        DATA(proxy) = NEW /zuora001/co_je_ecc__zuora004( destination = lo_destination ).
        DATA(request) = VALUE /zuora001/je_ecc__zuora004__a1( documentheader = documentheader
                                                             accountgl-item = accountgl
                                                             currencyamount-item = currencyamount
                                                             accountreceivable-item = accountreceivable
                                                             accountpayable-item =  accountpayable
                                                             accounttax-item = accounttax
                                                          ).
        proxy->zuora004__acc_document_post(
          EXPORTING
            input = request
          IMPORTING
            output = DATA(response)
        ).

        LOOP AT response-return-item INTO DATA(ls_item).
          ls_ret-je_uid = gv_id.
          ls_ret-destination_name = destination_name.
          ls_ret-destination_system = destination_system.
          IF ls_item-type = 'S'.
            e_msg-inv_no = ls_item-message_v2+0(10).
          ENDIF.
          ls_ret-type = ls_item-type.
          ls_ret-res_id = ls_item-id.
          ls_ret-res_number = ls_item-number.
          ls_ret-message = ls_item-message.
          ls_ret-message_v1 = ls_item-message_v1 .
          ls_ret-message_v2 = ls_item-message_v2 .
          ls_ret-message_v3 = ls_item-message_v3 .
          ls_ret-message_v4 = ls_item-message_v4.
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
        ls_return-type  = 'E'.
        ls_return-message =  error_message.
        APPEND ls_return TO gt_invoice_ret.
        CLEAR ls_return.
      CATCH cx_ai_system_fault INTO DATA(ai_system_fault).
        error_message = |code: { ai_system_fault->code  } codetext: { ai_system_fault->errortext }|.
        ls_return-type  = 'E'.
        ls_return-message =  error_message.
        APPEND ls_return TO gt_invoice_ret.
        CLEAR ls_ret.
      CATCH cx_http_dest_provider_error.
        " handle error
        error_message = |code: { ai_system_fault->code  } codetext: { ai_system_fault->errortext }|.
        ls_return-type  = 'E'.
        ls_return-message =  error_message.
        APPEND ls_return TO gt_invoice_ret.
        CLEAR ls_ret.
    ENDTRY.
  ENDMETHOD.


  METHOD journal_rev_post_ecc.
    reversal = CORRESPONDING #( is_header_check ).
    reversal-pstng_date = |{ reversal-pstng_date+0(4) }-{ reversal-pstng_date+4(2) }-{ reversal-pstng_date+6(2) }|.
    IF reversal-vat_date  IS NOT INITIAL.
    reversal-vat_date   = |{ reversal-vat_date+0(4) }-{ reversal-vat_date+4(2) }-{ reversal-vat_date+6(2) }|.
    ENDIF.
    TRY.
        CLEAR:i_name .
        i_name = destination_name.
        DATA(lo_destination) = cl_soap_destination_provider=>create_by_cloud_destination(
         i_name       =  i_name
       ).
        DATA(proxy) = NEW /zuora001/co_ecc_rev__zuora004( destination = lo_destination ).
        DATA(request) = VALUE /zuora001/ecc_rev__zuora004__1( reversal = reversal

                                                          ).
        proxy->zuora004__acc_doc_rev_pos(
          EXPORTING
            input = request
          IMPORTING
            output = DATA(response)
        ).
        LOOP AT response-return-item INTO DATA(ls_item).
          ls_ret-je_uid = gv_id.
          ls_ret-destination_name = destination_name.
          ls_ret-destination_system = destination_system.
          IF ls_item-type = 'S'.
            e_msg-inv_no = ls_item-message_v2+0(10).
          ENDIF.
          ls_ret-type = ls_item-type.
          ls_ret-res_id = ls_item-id.
          ls_ret-res_number = ls_item-number.
          ls_ret-message = ls_item-message.
          ls_ret-message_v1 = ls_item-message_v1 .
          ls_ret-message_v2 = ls_item-message_v2 .
          ls_ret-message_v3 = ls_item-message_v3 .
          ls_ret-message_v4 = ls_item-message_v4.
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
        ls_return-type  = 'E'.
        ls_return-message =  error_message.
        APPEND ls_return TO gt_invoice_ret.
        CLEAR ls_return.
      CATCH cx_ai_system_fault INTO DATA(ai_system_fault).
        error_message = |code: { ai_system_fault->code  } codetext: { ai_system_fault->errortext }|.
        ls_return-type  = 'E'.
        ls_return-message =  error_message.
        APPEND ls_return TO gt_invoice_ret.
        CLEAR ls_ret.
      CATCH cx_http_dest_provider_error.
        " handle error
        error_message = |code: { ai_system_fault->code  } codetext: { ai_system_fault->errortext }|.
        ls_return-type  = 'E'.
        ls_return-message =  error_message.
        APPEND ls_return TO gt_invoice_ret.
        CLEAR ls_ret.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
