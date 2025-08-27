
CLASS lhc_R_JE_H DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      gt_invoice_h       TYPE STANDARD TABLE OF  /zuora001/t_je_h,
      gt_invoice_i       TYPE STANDARD TABLE OF  /zuora001/t_je_i,
      gt_invoice_C       TYPE STANDARD TABLE OF  /zuora001/t_je_c,
      gt_invoice_ret     TYPE STANDARD TABLE OF  /zuora001/t_je_r,
      gt_invoice_ar      TYPE STANDARD TABLE OF  /zuora001/t_je_z,
      gt_invoice_ap      TYPE STANDARD TABLE OF  /zuora001/t_je_v,
      gt_EXTENSION1      TYPE STANDARD TABLE OF  /zuora001/t_exth,
      gt_EXTENSION2      TYPE STANDARD TABLE OF  /zuora001/t_exti,
      gt_api_log         TYPE STANDARD TABLE OF  /zuora001/t_apic,
      gt_Customer_master TYPE STANDARD TABLE OF /zuora001/i_cust,
      gt_ACCOUNTTAX      TYPE STANDARD TABLE OF  /zuora001/t_JE_T,
      ls_ret             TYPE /zuora001/t_je_r,
      ls_api_call        TYPE /zuora001/t_apic,
      gv_timestamp1      TYPE timestampl,
      gv_timestamp_P     TYPE timestampl,
      gv_id              TYPE sysuuid_x16,
      gv_start_time      TYPE t,
      gv_je_end_time     TYPE t,
      gv_uuid            TYPE string,
      gv_object_key      TYPE string,
      gv_pos             TYPE i,
      gv_landscape       TYPE /zuora001/t_je_h-land_scape,
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

    DATA:item_GL              TYPE STANDARD TABLE OF  /zuora001/journal_entry_creat9,
         debtor_item          TYPE STANDARD TABLE OF /zuora001/journal_entry_crea13,
         creditor_item        TYPE STANDARD TABLE OF  /zuora001/journal_entry_crea16,
         product_tax_item     TYPE STANDARD TABLE OF /zuora001/journal_entry_c_tab2,
         withholding_tax_item TYPE STANDARD TABLE OF /zuora001/journal_entry_c_tab1,
         ls_item_gl           TYPE  /zuora001/journal_entry_creat9,
         ls_item_ar           TYPE  /zuora001/journal_entry_crea13,
         ls_item_ap           TYPE  /zuora001/journal_entry_crea13,
         tax                  TYPE STANDARD TABLE OF /zuora001/journal_entry_creat9-tax,
         ls_tax_det           TYPE /zuora001/journal_entry_creat2.

    DATA: lt_mes TYPE STANDARD TABLE OF char256.
    DATA: lv_tax_code TYPE /zuora001/product_taxation_ch1.

    CONSTANTS:gv_trans_curr  TYPE /zuora001/t_je_C-currency VALUE '00',
              gv_local_CURR  TYPE /zuora001/t_je_C-currency VALUE '10',
              gv_global_curr TYPE /zuora001/t_je_C-currency VALUE '30'.

PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /zuora001/r_je_h RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /zuora001/r_je_h.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_h.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_h.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_h RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /zuora001/r_je_h.

    METHODS rba_Accountgl FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_h\Accountgl FULL result_requested RESULT result LINK association_links.
*&------------------------------------------------------------------------------>
    METHODS rba_Accountreceivable FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_h\accountreceivable FULL result_requested RESULT result LINK association_links.

    METHODS rba_Accountpayable FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_h\accountpayable FULL result_requested RESULT result LINK association_links.
*&------------------------------------------------------------------------------->
 METHODS rba_ACCOUNTTAX FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_h\ACCOUNTTAX FULL result_requested RESULT result LINK association_links.
*&------------------------------------------------------------------------------->
    METHODS rba_Currencyamount FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_h\Currencyamount FULL result_requested RESULT result LINK association_links.
*&--------------------------------------------------------------------------------------------------->
    METHODS rba_Return FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_h\Return FULL result_requested RESULT result LINK association_links.

*&------------------------------------------------------------------------->
    METHODS rba_EXTENSION1 FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_h\extension1 FULL result_requested RESULT result LINK association_links.

    METHODS rba_EXTENSION2 FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_h\extension2 FULL result_requested RESULT result LINK association_links.
*&------------------------------------------------------------------------->

*&------------------------------------------------------------------------------------------------------------>
    METHODS cba_Accountgl FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_h\Accountgl.
*&-------------------------------------------------------------------------->
    METHODS cba_Accountreceivable FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_h\Accountreceivable.

    METHODS cba_Accountpayable FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_h\Accountpayable.
*&--------------------------------------------------------------------------->
    METHODS cba_Currencyamount FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_h\Currencyamount.

    METHODS cba_Return FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_h\Return.

    METHODS cba_EXTENSION1 FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_h\extension1 .

    METHODS cba_EXTENSION2 FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_h\extension2.

    METHODS cba_ACCOUNTTAX FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_je_h\accounttax.

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

CLASS lhc_R_JE_H IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    CLEAR:customer_id,destination_name,destination_system,gv_je_user_name,gv_id,gv_uuid .
    GET TIME STAMP FIELD gv_timestamp1.
    CONVERT TIME STAMP gv_timestamp1 TIME ZONE 'UTC' INTO DATE DATA(gv_start_date) TIME DATA(gv_start_time).
*    gv_start_time = sy-uzeit.
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
      IF gt_invoice_h[ 1 ]-ref_doc_no_long = '5C'.
      ls_api_call-capability_id       = 4.
      ELSE.
      ls_api_call-capability_id       = 1.
      ENDIF.
      ls_api_call-je_uid               = gv_id.
      ls_api_call-execution_time = gv_start_time.
      ls_api_call-customer_id          = customer_id.
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
        /zuora001/r_je_h  = VALUE #( FOR ls_entity IN entities
                                  (
                                      %cid = ls_entity-%cid
*                                      %key = ls_entity-%key
                                      je_uid = gv_uuid
                                      customer_id =  customer_id
                                   ) "For Loop
                                ) "
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

  METHOD rba_Accountgl.
  ENDMETHOD.

  METHOD rba_Currencyamount.
  ENDMETHOD.

  METHOD rba_Return.
  ENDMETHOD.

  METHOD cba_Accountgl.
    gt_invoice_i =  VALUE #(
                                  FOR ls_entity_cba IN entities_cba
                                       FOR ls_item_cba IN ls_entity_cba-%target
                                      LET ls_rap_items = CORRESPONDING /zuora001/t_je_I( ls_item_cba MAPPING FROM ENTITY )
                                          IN (
          je_uid = gv_id
          je_doc_number = ''
          customer_id =  customer_id
          destination_name = destination_name
          destination_system =  destination_system
          itemno_acc = ls_rap_items-itemno_acc
          gl_account = ls_rap_items-gl_account
          item_text = ls_rap_items-item_text
          stat_con = ls_rap_items-stat_con
          log_proc = ls_rap_items-log_proc
          ac_doc_no = ls_rap_items-ac_doc_no
          ref_key_1 = ls_rap_items-ref_key_1
          ref_key_2 = ls_rap_items-ref_key_2
          ref_key_3 = ls_rap_items-ref_key_3
          acct_key = ls_rap_items-acct_key
          acct_type = ls_rap_items-acct_type
          doc_type = ls_rap_items-doc_type
          comp_code = ls_rap_items-comp_code
          bus_area = ls_rap_items-bus_area
          func_area = ls_rap_items-func_area
          plant = ls_rap_items-plant
          fis_period = ls_rap_items-fis_period
          fisc_year = ls_rap_items-fisc_year
          pstng_date = ls_rap_items-pstng_date
          value_date = ls_rap_items-value_date
          fm_area = ls_rap_items-fm_area
          customer = ls_rap_items-customer
          cshdis_ind = ls_rap_items-cshdis_ind
          vendor_no = ls_rap_items-vendor_no
          alloc_nmbr = ls_rap_items-alloc_nmbr
          tax_code = ls_rap_items-tax_code
          taxjurcode = ls_rap_items-taxjurcode
          ext_object_id = ls_rap_items-ext_object_id
          bus_scenario = ls_rap_items-bus_scenario
          costobject = ls_rap_items-costobject
          costcenter = ls_rap_items-costcenter
          acttype = ls_rap_items-acttype
          profit_ctr = ls_rap_items-profit_ctr
          part_prctr = ls_rap_items-part_prctr
          network = ls_rap_items-network
          wbs_element = ls_rap_items-wbs_element
          orderid = ls_rap_items-orderid
          order_itno = ls_rap_items-order_itno
          routing_no = ls_rap_items-routing_no
          activity = ls_rap_items-activity
          cond_type = ls_rap_items-cond_type
          cond_count = ls_rap_items-cond_count
          cond_st_no = ls_rap_items-cond_st_no
          fund = ls_rap_items-fund
          funds_ctr = ls_rap_items-funds_ctr
          cmm_item = ls_rap_items-cmm_item
          co_busproc = ls_rap_items-co_busproc
          asset_no = ls_rap_items-asset_no
          sub_number = ls_rap_items-sub_number
          bill_type = ls_rap_items-bill_type
          sales_ord = ls_rap_items-sales_ord
          s_ord_item = ls_rap_items-s_ord_item
          distr_chan = ls_rap_items-distr_chan
          division = ls_rap_items-division
          salesorg = ls_rap_items-salesorg
          sales_grp = ls_rap_items-sales_grp
          sales_off = ls_rap_items-sales_off
          sold_to = ls_rap_items-sold_to
          de_cre_ind = ls_rap_items-de_cre_ind
          p_el_prctr = ls_rap_items-p_el_prctr
          xmfrw = ls_rap_items-xmfrw
          quantity = ls_rap_items-quantity
          base_uom = ls_rap_items-base_uom
          base_uom_iso = ls_rap_items-base_uom_iso
          inv_qty = ls_rap_items-inv_qty
          inv_qty_su = ls_rap_items-inv_qty_su
          sales_unit = ls_rap_items-sales_unit
          sales_unit_iso = ls_rap_items-sales_unit_iso
          po_pr_qnt = ls_rap_items-po_pr_qnt
          po_pr_uom = ls_rap_items-po_pr_uom
          po_pr_uom_iso = ls_rap_items-po_pr_uom_iso
          entry_qnt = ls_rap_items-entry_qnt
          entry_uom = ls_rap_items-entry_uom
          entry_uom_iso = ls_rap_items-entry_uom_iso
          volume = ls_rap_items-volume
          volumeunit = ls_rap_items-volumeunit
          volumeunit_iso = ls_rap_items-volumeunit_iso
          gross_wt = ls_rap_items-gross_wt
          net_weight = ls_rap_items-net_weight
          unit_of_wt = ls_rap_items-unit_of_wt
          unit_of_wt_iso = ls_rap_items-unit_of_wt_iso
          item_cat = ls_rap_items-item_cat
          material = ls_rap_items-material
          matl_type = ls_rap_items-matl_type
          mvt_ind = ls_rap_items-mvt_ind
          reval_ind = ls_rap_items-reval_ind
          orig_group = ls_rap_items-orig_group
          orig_mat = ls_rap_items-orig_mat
          serial_no = ls_rap_items-serial_no
          part_acct = ls_rap_items-part_acct
          tr_part_ba = ls_rap_items-tr_part_ba
          trade_id = ls_rap_items-trade_id
          val_area = ls_rap_items-val_area
          val_type = ls_rap_items-val_type
          asval_date = ls_rap_items-asval_date
          po_number = ls_rap_items-po_number
          po_item = ls_rap_items-po_item
          itm_number = ls_rap_items-itm_number
          cond_category = ls_rap_items-cond_category
          func_area_long = ls_rap_items-func_area_long
          cmm_item_long = ls_rap_items-cmm_item_long
          grant_nbr = ls_rap_items-grant_nbr
          cs_trans_t = ls_rap_items-cs_trans_t
          measure = ls_rap_items-measure
          segment = ls_rap_items-segment
          partner_segment = ls_rap_items-partner_segment
          res_doc = ls_rap_items-res_doc
          res_item = ls_rap_items-res_item
          billing_period_start_date = ls_rap_items-billing_period_start_date
          billing_period_end_date = ls_rap_items-billing_period_end_date
          ppa_ex_ind = ls_rap_items-ppa_ex_ind
          fastpay = ls_rap_items-fastpay
          partner_grant_nbr = ls_rap_items-partner_grant_nbr
          budget_period = ls_rap_items-budget_period
          partner_budget_period = ls_rap_items-partner_budget_period
          partner_fund = ls_rap_items-partner_fund
          itemno_tax = ls_rap_items-itemno_tax
          housebank = ls_rap_items-housebank
          housebankaccount = ls_rap_items-housebankaccount
        )
      ).
  ENDMETHOD.

  METHOD cba_Currencyamount.
    gt_invoice_c = VALUE #(
      FOR ls_entity_cba IN entities_cba
      FOR ls_item_cba IN ls_entity_cba-%target
      LET ls_rap_items = CORRESPONDING /zuora001/t_je_c( ls_item_cba MAPPING FROM ENTITY )
      IN (
        client = ls_rap_items-client
        je_uid = gv_id
        je_doc_number = ''
        customer_id =  customer_id
        destination_name = destination_name
        destination_system =  destination_system
        itemno_acc = ls_rap_items-itemno_acc
        curr_type = ls_rap_items-curr_type
        currency = ls_rap_items-currency
        currency_iso = ls_rap_items-currency_iso
        amt_doccur = ls_rap_items-amt_doccur
        exch_rate = ls_rap_items-exch_rate
        exch_rate_v = ls_rap_items-exch_rate_v
        amt_base = ls_rap_items-amt_base
        disc_base = ls_rap_items-disc_base
        disc_amt = ls_rap_items-disc_amt
        tax_amt = ls_rap_items-tax_amt
      )
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
        DATA(error_message) = lx_uuid_error->get_text(  ).
        ls_ret-type  = 'E'.
        ls_ret-message =  error_message.
        APPEND ls_ret TO gt_invoice_ret.
        CLEAR ls_ret.
    ENDTRY.
    GET TIME STAMP FIELD gv_timestamp1.
    CONVERT TIME STAMP gv_timestamp1 TIME ZONE 'UTC' INTO DATE DATA(gv_start_date) TIME DATA(gv_je_end_time).
    DATA(lv_count) = lines( gt_invoice_i ).  " Count the number of entries in GT_INVOICE_I
    ls_api_call-client                = sy-mandt.
    IF gt_invoice_h[ 1 ]-ref_doc_no_long = '5C'.
      ls_api_call-capability_id       = 4.
    ELSE.
      ls_api_call-capability_id       = 1.
    ENDIF.
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
    ls_api_call-created_at = gv_timestamp_P.
    ls_api_call-posting_type = 'P'.
    ls_api_call-local_changed_by      = sy-uname.
    ls_api_call-local_last_changed_at = gv_timestamp_P.
    ls_api_call-last_changed_at       = gv_timestamp_P.
    MODIFY /zuora001/t_apic FROM @ls_api_call.
    CLEAR:ls_api_call,lv_count,gv_je_end_time,gv_start_time,gv_je_user_name.

** Update New Invoice Number in Global Table Invoice-Header
    LOOP AT gt_invoice_h ASSIGNING FIELD-SYMBOL(<fs_hdr>).
      IF <fs_hdr>-je_uid IS NOT INITIAL.
        <fs_hdr>-je_doc_number = gv_invoice.
      ENDIF.
    ENDLOOP.

** Update New Invoice Number in Global Table Invoice-Item
    LOOP AT gt_invoice_i ASSIGNING FIELD-SYMBOL(<fs_Item>).
      IF <fs_Item>-je_uid IS NOT INITIAL.
        <fs_Item>-je_doc_number = gv_invoice.
      ENDIF.
    ENDLOOP.


    LOOP AT gt_invoice_C ASSIGNING FIELD-SYMBOL(<fs_Item_C>).
      IF <fs_Item_C>-je_uid IS NOT INITIAL.
        <fs_Item_C>-je_doc_number = gv_invoice.
      ENDIF.
    ENDLOOP.


    LOOP AT gt_invoice_ar ASSIGNING FIELD-SYMBOL(<fs_Item_ar>).
      IF <fs_Item_ar>-je_uid IS NOT INITIAL.
        <fs_Item_ar>-je_doc_number = gv_invoice.
      ENDIF.
    ENDLOOP.


    LOOP AT gt_invoice_ap ASSIGNING FIELD-SYMBOL(<fs_Item_ap>).
      IF <fs_Item_ap>-je_uid IS NOT INITIAL.
        <fs_Item_ap>-je_doc_number = gv_invoice.
      ENDIF.
    ENDLOOP.


    LOOP AT gt_invoice_ret ASSIGNING FIELD-SYMBOL(<fs_Item_r>).
      IF <fs_Item_r>-je_uid IS INITIAL.
        <fs_Item_r>-je_uid = gv_id.
      ENDIF..
      IF <fs_Item_r>-je_uid IS NOT INITIAL.
        <fs_Item_r>-je_doc_number = gv_invoice.
      ENDIF.
    ENDLOOP.

    LOOP AT gt_invoice_ret ASSIGNING <fs_Item_r>.
      IF <fs_Item_r>-customer_id IS INITIAL.
        <fs_Item_r>-customer_id = customer_id.
      ENDIF.
      IF <fs_Item_r>-je_uid IS INITIAL.
        <fs_Item_r>-je_uid = gv_id.
      ENDIF..
      IF <fs_Item_r>-je_uid IS NOT INITIAL.
        <fs_Item_r>-je_doc_number = gv_invoice.
      ENDIF.
    ENDLOOP.

    LOOP AT gt_accounttax ASSIGNING FIELD-SYMBOL(<fs_tax>).
      IF <fs_tax>-je_uid IS INITIAL.
        <fs_tax>-je_uid = gv_id.
      ENDIF.
      IF <fs_tax>-je_uid IS NOT INITIAL.
        <fs_tax>-je_doc_number = gv_invoice.
      ENDIF.
    ENDLOOP.
    mapped =  VALUE #(
              /zuora001/r_je_h  = VALUE #(
                                 FOR ls_entity_h IN entities_cba
                                   (
                                       %cid = ls_entity_h-%cid_ref
*                                       %key = ls_entity_h-%key
                                       je_uid = gv_id
                                       JeDocNumber = gv_invoice
                                       customer_id =  customer_id
                                   )
                                 )
              /zuora001/r_je_c = VALUE #(
                             FOR i = 1 WHILE i <= lines( entities_cba )
                             LET lt_items = VALUE #( entities_cba[ i ]-%target OPTIONAL )
                             IN
                                 FOR j = 1 WHILE j <= lines( lt_items )
                                         LET ls_curee_item = VALUE #( lt_items[ j ] OPTIONAL )
                                         IN  (
                                                 %cid = ls_curee_item-%cid
*                                                 %key = ls_curee_item-%key
                                                 je_uid = gv_id
                                                 JeDocNumber = gv_invoice
                                                 customer_id =  customer_id
                                             ) "LET-IN
                                      )"
                  )."
  ENDMETHOD.

  METHOD cba_Return.
    gt_invoice_ret = VALUE #(
     FOR ls_entity_cba IN entities_cba
     FOR ls_item_cba IN ls_entity_cba-%target
     LET ls_rap_ret = CORRESPONDING /zuora001/T_je_R( ls_item_cba MAPPING FROM ENTITY )
     IN (
       client = ls_rap_ret-client
       je_uid = gv_id
       je_doc_number = ''
       customer_id = customer_id
       destination_name = destination_name
       destination_system =  destination_system
       type = ls_rap_ret-type
       res_id = ls_rap_ret-res_id
       res_number = ls_rap_ret-res_number
       message = ls_rap_ret-message
       log_no = ls_rap_ret-log_no
       log_msg_no = ls_rap_ret-log_msg_no
       message_v1 = ls_rap_ret-message_v1
       message_v2 = ls_rap_ret-message_v2
       message_v3 = ls_rap_ret-message_v3
       message_v4 = ls_rap_ret-message_v4
       res_parameter = ls_rap_ret-res_parameter
       res_row = ls_rap_ret-res_row
       field = ls_rap_ret-field
       res_system = ls_rap_ret-res_system
     )
   ).
** Sending Data back to UI
    mapped = VALUE #(
            /zuora001/r_je_h  = VALUE #(
                                FOR ls_entity_h IN entities_cba
                                  (
                                      %cid = ls_entity_h-%cid_ref
                                      %key = ls_entity_h-%key
*                                     je_uid = gv_id
*                                      JeDocNumber = gv_invoice
                                  )"
                                ) "
            /zuora001/r_je_r = VALUE #(
                                 FOR ls_head IN entities_cba
                                   FOR ls_log IN gt_invoice_ret "gt_errors
                                            (
                                                %cid = ls_head-%cid_ref
                                                Je_Uid = gv_id
*                                                JeDocNumber = gv_invoice
*                                                customer_id = ls_log-customer_id
                                                message  = ls_log-message
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
        ls_ret-type  = 'E'.
        ls_ret-message =  error_message.
        APPEND ls_ret TO gt_invoice_ret.
        CLEAR ls_ret.
    ENDTRY.
  ENDMETHOD.

  METHOD get_next_invoice_id.
*    SELECT MAX( je_doc_number ) FROM /zuora001/t_je_h INTO @DATA(lv_inv_id).
*    rv_inv_id = lv_inv_id + 1.
  ENDMETHOD.

  METHOD post_invoice .
    IF gt_invoice_h IS NOT INITIAL.
      DATA(ls_header_check) = VALUE #( gt_invoice_h[ 1 ] OPTIONAL ).
    ENDIF.
*&------------------------------------------------------------------------------->

*&------------------------------------------------------------------------------->
*& JE Header Validation
    " Instantiate the validation class
    DATA(lo_validator)  = NEW /zuora001/je_validation( ).
    DATA(lo_process_je) = NEW /zuora001/process_je( ).
    DATA(lo_process_journal_ecc) = NEW /zuora001/ecc_journal_post( ).
    " Call the validation method
    lo_validator->validate_header( EXPORTING is_header_check = ls_header_check
                                   IMPORTING gt_invoice_ret  = gt_invoice_ret ).
*&-------------------------------------------------------------------------------
*&------------------------------------------------------------------------------->
    CLEAR:gv_customer_id.
    IF gt_invoice_ret[] IS INITIAL.
      lo_validator->value_mapping_transform( CHANGING is_header_check = ls_header_check
                                             it_item_record  = gt_invoice_i
                                             gt_invoice_ret  = gt_invoice_ret ).

*&----------------------------------------------------------------------------------------->
*&
     lo_process_je->get_system_version( EXPORTING customer_id = customer_id
                                                  destination_name = destination_name
                                        CHANGING  landscape = gv_landscape ).
      IF gv_landscape = 'PRI'.
        lo_process_journal_ecc->journal_post_ecc( EXPORTING destination_name  = destination_name
                                                   is_header_check = ls_header_check
                                                   gv_id =  gv_id
                                                   destination_system = destination_system
                                                   CHANGING gt_invoice_i = gt_invoice_i
                                                   gt_invoice_c  = gt_invoice_c
                                                   gt_invoice_ar = gt_invoice_ar
                                                   gt_invoice_ap = gt_invoice_ap
                                                   gt_invoice_h  = gt_invoice_h
                                                   gt_invoice_ret = gt_invoice_ret
                                                   gt_accounttax  = gt_accounttax
                                                   e_msg = e_msg ).

      ELSE.
*&----------------------------------------------------------------------------------------->
        TRY.
            CLEAR:i_name .
            i_name = destination_name.
            DATA(lo_destination) = cl_soap_destination_provider=>create_by_cloud_destination(
             i_name       =  i_name

           ).
            DATA(proxy) = NEW /zuora001/co_journal_entry_cre( destination = lo_destination ).
            IF gt_invoice_h IS NOT INITIAL.
              DATA(ls_header) = VALUE #( gt_invoice_h[ 1 ] OPTIONAL ).
            ENDIF.
*&--------------------------------------------------------------------------------------------->
*& G/L Posting
*&--------------------------------------------------------------------------------------------->
            IF gt_invoice_i IS NOT INITIAL.
              lo_process_je->process_gl( EXPORTING is_header_check = ls_header_check
                                         CHANGING  item_gl = item_gl
                                         gt_invoice_i = gt_invoice_i
                                         gt_invoice_c = gt_invoice_c
                                         gt_invoice_ret = gt_invoice_ret ).
            ENDIF.
*&--------------------------------------------------------------------------------------------->
*& AR Posting
*&--------------------------------------------------------------------------------------------->
            IF gt_invoice_ar IS NOT INITIAL.
              lo_process_je->process_ar( EXPORTING is_header_check = ls_header_check
                                         CHANGING debtor_item = debtor_item
                                                  gt_invoice_ar = gt_invoice_ar
                                                  gt_invoice_c  = gt_invoice_c
                                                  gt_invoice_ret = gt_invoice_ret ).
            ENDIF.
*&--------------------------------------------------------------------------------------------->

*&--------------------------------------------------------------------------------------------->
*& AP Posting
*&--------------------------------------------------------------------------------------------->
            IF gt_invoice_ap IS NOT INITIAL.
              lo_process_je->process_ap( EXPORTING is_header_check = ls_header_check
                                         CHANGING creditor_item    = creditor_item
                                                  gt_invoice_ap    = gt_invoice_ap
                                                  gt_invoice_c     = gt_invoice_c
                                                  gt_invoice_ret   = gt_invoice_ret ).
            ENDIF.
*&--------------------------------------------------------------------------------------------->




            DATA(request) = VALUE /zuora001/journal_entry_bulk_c(
           journal_entry_bulk_create_requ = VALUE #( message_header = VALUE #( creation_date_time  = gv_timestamp1 "20240201110011 "'2018-06-05T12:00:00.1234567Z'
                                                                               test_data_indicator = '' ) "Pass 'X'-Document check - no errors: BKPFF $
                      journal_entry_create_request = VALUE #(
                                (
                                   journal_entry = VALUE #(
                                                    original_reference_document_ty  = ls_header_check-obj_type
                                                    business_transaction_type = ls_header_check-bus_act
                                                    accounting_document_type = ls_header_check-doc_type
                                                    company_code = ls_header_check-comp_code
                                                    created_by_user = ls_header_check-username
                                                    document_date = ls_header_check-doc_date
                                                    posting_date = ls_header_check-pstng_date
                                                    document_header_text = ls_header_check-header_txt
                                                    document_reference_id = ls_header_check-ref_doc_no
                                                    reversal_reason  = ls_header_check-reason_rev
                                                    exchange_rate = ls_header_check-exchange_rate
                                                    item = item_GL
                                                    debtor_item =  debtor_item
                                                    creditor_item = creditor_item
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
  METHOD rba_extension1.

  ENDMETHOD.

  METHOD rba_extension2.

  ENDMETHOD.

  METHOD cba_extension1.

  ENDMETHOD.

  METHOD cba_extension2.

  ENDMETHOD.

  METHOD rba_accountreceivable.

  ENDMETHOD.

  METHOD rba_accountpayable.

  ENDMETHOD.

  METHOD cba_accountreceivable.

    gt_invoice_ar = VALUE #(
      FOR ls_entity_cba IN entities_cba
      FOR ls_item_cba IN ls_entity_cba-%target
      LET ls_rap_items = CORRESPONDING /zuora001/t_je_z( ls_item_cba MAPPING FROM ENTITY )
      IN (
        client              = ls_rap_items-client
        je_uid              = gv_id
        customer_id         = customer_id
        je_doc_number       = ''
        destination_name    = destination_name
        destination_system  = destination_system
        itemno_acc          = ls_rap_items-itemno_acc
        customer            = ls_rap_items-customer
        gl_account          = ls_rap_items-gl_account
        ref_key_1           = ls_rap_items-ref_key_1
        ref_key_2           = ls_rap_items-ref_key_2
        ref_key_3           = ls_rap_items-ref_key_3
        comp_code           = ls_rap_items-comp_code
        bus_area            = ls_rap_items-bus_area
        tax_code = ls_rap_items-tax_code
        pmnttrms            = ls_rap_items-pmnttrms
        bline_date          = ls_rap_items-bline_date
        dsct_days1          = ls_rap_items-dsct_days1
        dsct_days2          = ls_rap_items-dsct_days2
        netterms            = ls_rap_items-netterms
        dsct_pct1           = ls_rap_items-dsct_pct1
        dsct_pct2           = ls_rap_items-dsct_pct2
        pymt_meth           = ls_rap_items-pymt_meth
        pmtmthsupl          = ls_rap_items-pmtmthsupl
        paymt_ref           = ls_rap_items-paymt_ref
        dunn_key            = ls_rap_items-dunn_key
        dunn_block          = ls_rap_items-dunn_block
        pmnt_block          = ls_rap_items-pmnt_block
        vat_reg_no          = ls_rap_items-vat_reg_no
        alloc_nmbr          = ls_rap_items-alloc_nmbr
        item_text           = ls_rap_items-item_text
        partner_bk          = ls_rap_items-partner_bk
        housebank           = ls_rap_items-housebank
        housebankaccount    = ls_rap_items-housebankaccount
      )
    ).


  ENDMETHOD.

  METHOD cba_accountpayable.

    gt_invoice_ap = VALUE #(
    FOR ls_entity_cba IN entities_cba
    FOR ls_item_cba IN ls_entity_cba-%target
    LET ls_rap_items = CORRESPONDING /zuora001/t_je_v( ls_item_cba MAPPING FROM ENTITY )
    IN (
      client              = ls_rap_items-client
      je_uid              = gv_id
      customer_id         = customer_id
      je_doc_number       = ''
      destination_name    = destination_name
      destination_system  = destination_system
      vendor_no           = ls_rap_items-vendor_no
      itemno_acc          = ls_rap_items-itemno_acc
      gl_account          = ls_rap_items-gl_account
      ref_key_1           = ls_rap_items-ref_key_1
      ref_key_2           = ls_rap_items-ref_key_2
      ref_key_3           = ls_rap_items-ref_key_3
      comp_code           = ls_rap_items-comp_code
      bus_area            = ls_rap_items-bus_area
      pmnttrms            = ls_rap_items-pmnttrms
      bline_date          = ls_rap_items-bline_date
      dsct_days1          = ls_rap_items-dsct_days1
      dsct_days2          = ls_rap_items-dsct_days2
      netterms            = ls_rap_items-netterms
      dsct_pct1           = ls_rap_items-dsct_pct1
      dsct_pct2           = ls_rap_items-dsct_pct2
      pymt_meth           = ls_rap_items-pymt_meth
      pmtmthsupl          = ls_rap_items-pmtmthsupl
      pmnt_block          = ls_rap_items-pmnt_block
      scbank_ind          = ls_rap_items-scbank_ind
      supcountry          = ls_rap_items-supcountry
      supcountry_iso      = ls_rap_items-supcountry_iso
      bllsrv_ind          = ls_rap_items-bllsrv_ind
      alloc_nmbr          = ls_rap_items-alloc_nmbr
      item_text           = ls_rap_items-item_text
      po_sub_no           = ls_rap_items-po_sub_no
      po_checkdg          = ls_rap_items-po_checkdg
      po_ref_no           = ls_rap_items-po_ref_no
      pymt_cur_iso        = ls_rap_items-pymt_cur_iso
      sp_gl_ind           = ls_rap_items-sp_gl_ind
      tax_code            = ls_rap_items-tax_code
      tax_date            = ls_rap_items-tax_date
      taxjurcode          = ls_rap_items-taxjurcode
      alt_payee           = ls_rap_items-alt_payee
      alt_payee_bank      = ls_rap_items-alt_payee_bank
      partner_bk          = ls_rap_items-partner_bk
      bank_id             = ls_rap_items-bank_id
      partner_guid        = ls_rap_items-partner_guid
      profit_ctr          = ls_rap_items-profit_ctr
      fund                = ls_rap_items-fund
      w_tax_code          = ls_rap_items-w_tax_code
      businessplace       = ls_rap_items-businessplace
      sectioncode         = ls_rap_items-sectioncode
      instr1              = ls_rap_items-instr1
      instr2              = ls_rap_items-instr2
      instr3              = ls_rap_items-instr3
      instr4              = ls_rap_items-instr4
      branch              = ls_rap_items-branch
      pymt_cur            = ls_rap_items-pymt_cur
      pymt_amt            = ls_rap_items-pymt_amt
      grant_nbr           = ls_rap_items-grant_nbr
      measure             = ls_rap_items-measure
      housebankacctid     = ls_rap_items-housebankacctid
      budget_period       = ls_rap_items-budget_period
      ppa_ex_ind          = ls_rap_items-ppa_ex_ind
      part_businessplace  = ls_rap_items-part_businessplace
      housebank           = ls_rap_items-housebank
      housebankaccount    = ls_rap_items-housebankaccount
    )
  ).


  ENDMETHOD.

  METHOD rba_accounttax.

  ENDMETHOD.

  METHOD cba_accounttax.
  gt_accounttax = VALUE #(
      FOR ls_entity_cba IN entities_cba
      FOR ls_item_cba   IN ls_entity_cba-%target
      LET ls_rap = CORRESPONDING /zuora001/t_je_t( ls_item_cba MAPPING FROM ENTITY )
      IN (
        client             = sy-mandt
        je_uid             = gv_id
        customer_id        = customer_id
        je_doc_number      = ''
        itemno_acc         = ls_rap-itemno_acc
        destination_system = destination_system
        destination_name   = destination_name
        gl_account         = ls_rap-gl_account
        cond_key           = ls_rap-cond_key
        acct_key           = ls_rap-acct_key
        tax_code           = ls_rap-tax_code
        tax_rate           = ls_rap-tax_rate
        tax_date           = ls_rap-tax_date
        taxjurcode         = ls_rap-taxjurcode
        taxjurcode_deep    = ls_rap-taxjurcode_deep
        taxjurcode_level   = ls_rap-taxjurcode_level
        itemno_tax         = ls_rap-itemno_tax
        direct_tax         = ls_rap-direct_tax
      )
    ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_JE_C DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_c.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_c.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_c RESULT result.

    METHODS rba_Documentheader FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_c\Documentheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_JE_C IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Documentheader.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_JE_I DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_i.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_i.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_i RESULT result.

    METHODS rba_Documentheader FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_i\Documentheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_JE_I IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Documentheader.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_JE_R DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_r.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_r.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_r RESULT result.

    METHODS rba_Documentheader FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_r\Documentheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_/zuora001/r_je_z DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_z.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_z.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_z RESULT result.

    METHODS rba_Documentheader FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_z\Documentheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_/zuora001/r_je_z IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Documentheader.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_vendorje DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE VendorJE.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE VendorJE.

    METHODS read FOR READ
      IMPORTING keys FOR READ VendorJE RESULT result.

    METHODS rba_Documentheader FOR READ
      IMPORTING keys_rba FOR READ VendorJE\Documentheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_vendorje IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Documentheader.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_JE_R IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Documentheader.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_/zuora001/r_je_exth DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_exth.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_exth.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_exth RESULT result.

    METHODS rba_Documentheader FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_exth\Documentheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_/zuora001/r_je_exth IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Documentheader.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_/zuora001/r_je_exti DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_je_exti.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_je_exti.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_je_exti RESULT result.

    METHODS rba_Documentheader FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_je_exti\Documentheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_/zuora001/r_je_exti IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Documentheader.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_R_JE_H DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_R_JE_H IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
** Save Invoice Header Data
    IF NOT lhc_R_JE_H=>gt_invoice_h IS INITIAL.
      MODIFY /zuora001/t_je_h FROM TABLE @lhc_R_JE_H=>gt_invoice_h.
    ENDIF.
** Save Invoice Item Data
    IF lhc_R_JE_H=>gt_invoice_i IS NOT INITIAL.
      MODIFY /zuora001/t_je_i FROM TABLE @lhc_R_JE_H=>gt_invoice_i.
    ENDIF.
** Save Currecny Structure
    IF lhc_R_JE_H=>gt_invoice_c IS NOT INITIAL.
      MODIFY /zuora001/t_je_c FROM TABLE @lhc_R_JE_H=>gt_invoice_c.
    ENDIF.
** Save Return Structure
    IF lhc_R_JE_H=>gt_invoice_ret IS NOT INITIAL.
      MODIFY /zuora001/t_je_r FROM TABLE @lhc_R_JE_H=>gt_invoice_ret .
    ENDIF.


    IF lhc_R_JE_H=>gt_invoice_ar IS NOT INITIAL.
      MODIFY /zuora001/t_je_z FROM TABLE @lhc_R_JE_H=>gt_invoice_ar .
    ENDIF.

    IF lhc_R_JE_H=>gt_invoice_ap IS NOT INITIAL.
      MODIFY /zuora001/t_je_v FROM TABLE @lhc_R_JE_H=>gt_invoice_ap .
    ENDIF.
      IF lhc_R_JE_H=>gt_ACCOUNTTAX IS NOT INITIAL.
      MODIFY /zuora001/t_je_t FROM TABLE @lhc_R_JE_H=>gt_ACCOUNTTAX .
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
