CLASS /zuora001/process_je DEFINITION
   PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

  CONSTANTS :gv_active TYPE /zuora001/i_cust-Status VALUE '1'.

    CONSTANTS:gv_trans_curr  TYPE /zuora001/t_je_C-currency VALUE '00',
              gv_local_CURR  TYPE /zuora001/t_je_C-currency VALUE '10',
              gv_global_curr TYPE /zuora001/t_je_C-currency VALUE '30'.

    DATA:ls_ret              TYPE /zuora001/t_je_r,
         gv_customer_id      TYPE /zuora001/decustomerid,
         gv_destination_name TYPE /zuora001/t_dest-destination_name.

    DATA:gt_Customer_master TYPE STANDARD TABLE OF /zuora001/i_cust,
         gt_dest_master     TYPE STANDARD TABLE OF /zuora001/i_dest,
         debtor_item        TYPE STANDARD TABLE OF /zuora001/journal_entry_crea13,
         gt_VALUE_MAPPING   TYPE STANDARD TABLE OF /zuora001/c_je_mapc.

    TYPES:gt_invoice_return TYPE STANDARD TABLE OF  /zuora001/t_je_r,
          gt_debtor_item    TYPE STANDARD TABLE OF /zuora001/journal_entry_crea13,
          gt_creditor_item  TYPE STANDARD TABLE OF  /zuora001/journal_entry_crea16,
          gt_invoice_ar     TYPE STANDARD TABLE OF  /zuora001/t_je_z,
          gt_invoice_i      TYPE STANDARD TABLE OF  /zuora001/t_je_i,
          item_GL           TYPE STANDARD TABLE OF  /zuora001/journal_entry_creat9,
          gt_invoice_c      TYPE STANDARD TABLE OF  /zuora001/t_je_c,
          gt_invoice_ap     TYPE STANDARD TABLE OF  /zuora001/t_je_v,
          gt_item_record    TYPE STANDARD TABLE OF /zuora001/t_je_i,
          gt_ACCOUNTTAX      TYPE STANDARD TABLE OF  /zuora001/t_JE_T.

    DATA: ls_item_ar TYPE  /zuora001/journal_entry_crea13,
          ls_item_ap TYPE  /zuora001/journal_entry_crea16,
          ls_item_gl TYPE  /zuora001/journal_entry_creat9.

    METHODS process_gl
      IMPORTING REFERENCE(is_header_check) TYPE  /zuora001/t_je_h
      CHANGING  REFERENCE(gt_invoice_ret)  TYPE gt_invoice_return
                REFERENCE(gt_invoice_i)    TYPE gt_invoice_i
                REFERENCE(gt_invoice_c)    TYPE gt_invoice_c
                REFERENCE(item_GL)         TYPE item_GL.

    METHODS process_ar
      IMPORTING REFERENCE(is_header_check) TYPE  /zuora001/t_je_h
      CHANGING  REFERENCE(gt_invoice_ret)  TYPE gt_invoice_return
                REFERENCE(gt_invoice_ar)   TYPE gt_invoice_ar
                REFERENCE(gt_invoice_c)    TYPE gt_invoice_c
                REFERENCE(debtor_item)     TYPE gt_debtor_item.

    METHODS process_ap
      IMPORTING REFERENCE(is_header_check) TYPE  /zuora001/t_je_h
      CHANGING  REFERENCE(gt_invoice_ret)  TYPE gt_invoice_return
                REFERENCE(gt_invoice_ap)   TYPE gt_invoice_ap
                REFERENCE(gt_invoice_c)    TYPE gt_invoice_c
                REFERENCE(creditor_item)   TYPE gt_creditor_item.

    METHODS get_system_version
      IMPORTING  REFERENCE(customer_id) TYPE  /zuora001/t_je_h-customer_id
                 REFERENCE(destination_name)  TYPE /zuora001/t_je_h-destination_name
       CHANGING  REFERENCE(landscape)  TYPE /zuora001/t_je_h-land_scape.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/PROCESS_JE IMPLEMENTATION.


  METHOD get_system_version.

  SELECT SINGLE FROM /ZUORA001/I_DEST FIELDS landscape
       WHERE customerid    = @customer_id
         AND DestinationName = @destination_name
         AND Status = @gv_active
       INTO @landscape.

  ENDMETHOD.


  METHOD process_ap.
    IF gt_invoice_ap IS NOT INITIAL.
      LOOP AT gt_invoice_ap INTO DATA(ls_item_ap_req).
        ls_item_ap-reference_document_item = ls_item_ap_req-itemno_acc.
        ls_item_ap-creditor = ls_item_ap_req-vendor_no.
        READ   TABLE gt_invoice_C INTO DATA(ls_curr) WITH KEY itemno_acc = ls_item_ap_req-itemno_acc
                                                        curr_type  = gv_trans_curr.
        IF sy-subrc = 0.
          ls_item_ap-amount_in_transaction_currency-content = ls_curr-amt_doccur.
          ls_item_ap-amount_in_transaction_currency-currency_code = ls_curr-currency.
          IF ls_item_ap-amount_in_transaction_currency-content < 0.
            ls_item_ap-debit_credit_code = 'H'.
          ELSE.
            ls_item_ap-debit_credit_code = 'S'.
          ENDIF.
        ENDIF.
        READ   TABLE gt_invoice_C INTO ls_curr WITH KEY itemno_acc = ls_item_ap_req-itemno_acc
                                                      curr_type    = gv_local_curr.
        IF sy-subrc = 0.
          ls_item_ap-amount_in_company_code_currenc-content = ls_curr-amt_doccur.
          ls_item_ap-amount_in_company_code_currenc-currency_code = ls_curr-currency.
          IF ls_item_ap-amount_in_company_code_currenc-content < 0.
            ls_item_ap-debit_credit_code = 'H'.
          ELSE.
            ls_item_ap-debit_credit_code = 'S'.
          ENDIF.
        ENDIF.
        READ   TABLE gt_invoice_C INTO ls_curr WITH KEY itemno_acc = ls_item_ap_req-itemno_acc
                                                      curr_type    = gv_global_curr.
        IF sy-subrc = 0.
          ls_item_ap-amount_in_group_currency-content = ls_curr-amt_doccur.
          ls_item_ap-amount_in_group_currency-currency_code = ls_curr-currency.
          IF ls_item_ap-amount_in_group_currency-content < 0.
            ls_item_ap-debit_credit_code = 'H'.
          ELSE.
            ls_item_ap-debit_credit_code = 'S'.
          ENDIF.
        ENDIF.
        ls_item_ap-document_item_text = ls_item_ap_req-item_text.
        ls_item_ap-altv_recncln_accts-content = ls_item_ap_req-gl_account.
        ls_item_ap-assignment_reference = ls_item_ap_req-alloc_nmbr.
        APPEND ls_item_ap TO creditor_item.
        CLEAR:ls_item_ap.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD process_ar.
    IF gt_invoice_ar IS NOT INITIAL.
      LOOP AT gt_invoice_ar INTO DATA(ls_item_ar_req).
        ls_item_ar-reference_document_item = ls_item_ar_req-customer.
        ls_item_ar-debtor = ls_item_ar_req-customer.
        READ   TABLE gt_invoice_C INTO DATA(ls_curr) WITH KEY itemno_acc = ls_item_ar_req-itemno_acc
                                                        curr_type  = gv_trans_curr.
        IF sy-subrc = 0.
          ls_item_ar-amount_in_transaction_currency-content = ls_curr-amt_doccur.
          ls_item_ar-amount_in_transaction_currency-currency_code = ls_curr-currency.
          IF ls_item_ar-amount_in_transaction_currency-content < 0.
            ls_item_ar-debit_credit_code = 'H'.
          ELSE.
            ls_item_ar-debit_credit_code = 'S'.
          ENDIF.
        ENDIF.
        READ   TABLE gt_invoice_C INTO ls_curr WITH KEY itemno_acc = ls_item_ar_req-itemno_acc
                                                      curr_type    = gv_local_curr.
        IF sy-subrc = 0.
          ls_item_ar-amount_in_company_code_currenc-content = ls_curr-amt_doccur.
          ls_item_ar-amount_in_company_code_currenc-currency_code = ls_curr-currency.
          IF ls_item_ar-amount_in_company_code_currenc-content < 0.
            ls_item_ar-debit_credit_code = 'H'.
          ELSE.
            ls_item_ar-debit_credit_code = 'S'.
          ENDIF.
        ENDIF.
        READ   TABLE gt_invoice_C INTO ls_curr WITH KEY itemno_acc = ls_item_ar_req-itemno_acc
                                                      curr_type    = gv_global_curr.
        IF sy-subrc = 0.
          ls_item_ar-amount_in_group_currency-content = ls_curr-amt_doccur.
          ls_item_ar-amount_in_group_currency-currency_code = ls_curr-currency.
          IF ls_item_ar-amount_in_group_currency-content < 0.
            ls_item_ar-debit_credit_code = 'H'.
          ELSE.
            ls_item_ar-debit_credit_code = 'S'.
          ENDIF.
        ENDIF.
        ls_item_ar-document_item_text = ls_item_ar_req-item_text.
        ls_item_ar-altv_recncln_accts-content = ls_item_ar_req-gl_account.
        ls_item_ar-assignment_reference = ls_item_ar_req-alloc_nmbr.
        APPEND ls_item_ar TO debtor_item.
        CLEAR:ls_item_ar.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD process_gl.
    LOOP AT gt_invoice_i INTO DATA(ls_item_ACC_GL).
      ls_item_gl-reference_document_item = ls_item_ACC_GL-itemno_acc.
      ls_item_gl-glaccount-content = ls_item_ACC_GL-gl_account.
      READ   TABLE gt_invoice_C INTO DATA(ls_curr) WITH KEY itemno_acc = ls_item_ACC_GL-itemno_acc
                                                            curr_type  = gv_trans_curr.
      IF sy-subrc = 0.
        ls_item_gl-amount_in_transaction_currency-content = ls_curr-amt_doccur.
        ls_item_gl-amount_in_transaction_currency-currency_code = ls_curr-currency.
        IF ls_item_gl-amount_in_transaction_currency-content < 0.
          ls_item_gl-debit_credit_code = 'H'.
        ELSE.
          ls_item_gl-debit_credit_code = 'S'.
        ENDIF.
      ENDIF.
      READ   TABLE gt_invoice_C INTO ls_curr WITH KEY itemno_acc = ls_item_ACC_GL-itemno_acc
                                                        curr_type    = gv_local_curr.
      IF sy-subrc = 0.
        ls_item_gl-amount_in_company_code_currenc-content = ls_curr-amt_doccur.
        ls_item_gl-amount_in_company_code_currenc-currency_code = ls_curr-currency.
        IF ls_item_gl-amount_in_company_code_currenc-content < 0.
          ls_item_gl-debit_credit_code = 'H'.
        ELSE.
          ls_item_gl-debit_credit_code = 'S'.
        ENDIF.
      ENDIF.
      READ   TABLE gt_invoice_C INTO ls_curr WITH KEY itemno_acc = ls_item_ACC_GL-itemno_acc
                                                        curr_type    = gv_global_curr.
      IF sy-subrc = 0.
        ls_item_gl-amount_in_group_currency-content = ls_curr-amt_doccur.
        ls_item_gl-amount_in_group_currency-currency_code = ls_curr-currency.
        IF ls_item_gl-amount_in_group_currency-content < 0.
          ls_item_gl-debit_credit_code = 'H'.
        ELSE.
          ls_item_gl-debit_credit_code = 'S'.
        ENDIF.
      ENDIF.
      ls_item_gl-reference1idby_business_partne = ls_item_ACC_GL-ref_key_1.
      ls_item_gl-reference2idby_business_partne = ls_item_ACC_GL-ref_key_2.
      ls_item_gl-reference3idby_business_partne = ls_item_ACC_GL-ref_key_3.
      ls_item_gl-trading_partner = ls_item_ACC_GL-trade_id.
      ls_item_gl-value_date = ls_item_ACC_GL-value_date.
      ls_item_gl-document_item_text = ls_item_ACC_GL-item_text.
      ls_item_gl-house_bank = ls_item_ACC_GL-housebank.
      ls_item_gl-house_bank_account = ls_item_ACC_GL-housebankaccount.
      ls_item_gl-tax-tax_code-content = ls_item_ACC_GL-tax_code.
      ls_item_gl-tax-tax_jurisdiction-content = ls_item_ACC_GL-taxjurcode.
*          ls_item_gl-account_assignment-account_assignment_type = ls_item_ACC_GL-account_assignment_t.
      ls_item_gl-account_assignment-profit_center = ls_item_ACC_GL-profit_ctr.
      ls_item_gl-account_assignment-partner_profit_center = ls_item_ACC_GL-part_prctr.
      ls_item_gl-account_assignment-segment = ls_item_ACC_GL-segment.
      ls_item_gl-account_assignment-partner_segment = ls_item_ACC_GL-partner_segment.
      ls_item_gl-account_assignment-cost_center = ls_item_ACC_GL-costcenter.
*          ls_item_gl-account_assignment-cost_ctr_activity_type = ls_item_ACC_GL-resource_class_id.
      ls_item_gl-account_assignment-wbselement = ls_item_ACC_GL-wbs_element.
*          ls_item_gl-account_assignment-master_fixed_asset = ls_item_ACC_GL-master_fixed_asset_i.
*          ls_item_gl-account_assignment-work_item = ls_item_ACC_GL-w.
      ls_item_gl-account_assignment-fixed_asset = ls_item_ACC_GL-asset_no.
      ls_item_gl-account_assignment-sales_order = ls_item_ACC_GL-sales_ord.
      ls_item_gl-account_assignment-sales_order_item = ls_item_ACC_GL-s_ord_item.
      ls_item_gl-account_assignment-functional_area = ls_item_ACC_GL-func_area.
*          ls_item_gl-account_assignment-service_doc_type = ls_item_ACC_GL-service_doc_type.
*          ls_item_gl-account_assignment-service_doc_id = ls_item_ACC_GL-service_doc_id_gfn.
*          ls_item_gl-account_assignment-service_doc_item_id = ls_item_ACC_GL-service_doc_item_id_gfn.
      ls_item_gl-assignment_reference = ls_item_ACC_GL-alloc_nmbr.
      APPEND ls_item_gl TO item_GL  .
      CLEAR:ls_item_gl,ls_item_ACC_GL.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
