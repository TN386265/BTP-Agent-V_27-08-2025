CLASS lhc_R_BL_H DEFINITION INHERITING FROM cl_abap_behavior_handler.

PUBLIC SECTION.
    CLASS-DATA:
      gt_invoice_h       TYPE STANDARD TABLE OF /zuora001/t_bl_h,
      gt_invoice_i       TYPE STANDARD TABLE OF /zuora001/t_bl_i,   "BILLINGDATAIN
      gt_invoice_c       TYPE STANDARD TABLE OF /zuora001/t_bl_c,   "CONDITIONDATAIN
      gt_invoice_e       TYPE STANDARD TABLE OF /zuora001/t_bl_e,   "ERRORS
      gt_invoice_n       TYPE STANDARD TABLE OF /zuora001/t_bl_n,   "NFMETALLITMS
      gt_invoice_ret     TYPE STANDARD TABLE OF /zuora001/t_bl_r,   "RETURN
      gt_invoice_s       TYPE STANDARD TABLE OF /zuora001/t_bl_s,   "SUCCESS
      gt_invoice_t       TYPE STANDARD TABLE OF /zuora001/t_bl_t,   "TEXTDATAIN
      gt_invoice_v       TYPE STANDARD TABLE OF /zuora001/t_bl_v,   "CCARDDATAIN
      gt_extension1      TYPE STANDARD TABLE OF /zuora001/t_exth,
      gt_extension2      TYPE STANDARD TABLE OF /zuora001/t_exti,
      gt_api_log         TYPE STANDARD TABLE OF /zuora001/t_apic,
      gt_customer_master TYPE STANDARD TABLE OF /zuora001/i_cust,
      ls_ret             TYPE /zuora001/t_bl_r,
      ls_api_call        TYPE /zuora001/t_apic,
      gv_timestamp1      TYPE timestampl,
      gv_timestamp_p     TYPE timestampl,
      gv_id              TYPE sysuuid_x16,
      gv_start_time      TYPE t,
      gv_je_end_time     TYPE t,
      gv_uuid            TYPE string,
      gv_object_key      TYPE string,
      gv_pos             TYPE i,
      gv_landscape       TYPE /zuora001/t_bl_h-land_scape,
      gv_customer_id     TYPE /zuora001/decustomerid,
      gv_je_user_name    TYPE /zuora001/t_bl_h-username,
      customer_id        TYPE /zuora001/t_bl_h-customer_id,
      destination_system TYPE /zuora001/t_bl_h-destination_system,
      destination_name   TYPE /zuora001/t_bl_h-destination_name,
      gv_invoice         TYPE /zuora001/t_bl_h-bl_doc_number.

    DATA:ls_error TYPE /zuora001/t_bl_e.

    DATA: billingdatain   TYPE STANDARD TABLE OF /zuora001/blbapivbrk,          " BAPIVBRK
          conditiondatain TYPE STANDARD TABLE OF /zuora001/blbapikomv,          " BAPIKOMV
          ccarddatain     TYPE STANDARD TABLE OF /zuora001/blbapiccard_vf,      " BAPICCARD_VF
          textdatain      TYPE STANDARD TABLE OF /zuora001/blbapikomfktx,       " BAPIKOMFKTX
          errors          TYPE STANDARD TABLE OF /zuora001/blbapivbrkerrors,    " BAPIVBRKERRORS
          return          TYPE STANDARD TABLE OF /zuora001/blbapiret1,          " BAPIRET1
          success         TYPE STANDARD TABLE OF /zuora001/blbapivbrksuccess,   " BAPIVBRKSUCCESS
          nfmetallitms    TYPE STANDARD TABLE OF /zuora001/bl__nfm__bapidocitm, " /NFM/BAPIDOCITM
          creatordatain   TYPE /zuora001/blbapicreatordata.                     " CREATORDATAIN

    DATA: lv_URL        TYPE string,
          lv_URL_S4     TYPE string,
          i_name        TYPE string,
          lv_out_string TYPE string.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /zuora001/r_bl_h RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR /zuora001/r_bl_h RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /zuora001/r_bl_h.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_h.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_h.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_h RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /zuora001/r_bl_h.

    METHODS rba_Billingdatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_h\Billingdatain FULL result_requested RESULT result LINK association_links.

    METHODS rba_Ccarddatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_h\Ccarddatain FULL result_requested RESULT result LINK association_links.

    METHODS rba_Conditiondatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_h\Conditiondatain FULL result_requested RESULT result LINK association_links.

    METHODS rba_Errors FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_h\Errors FULL result_requested RESULT result LINK association_links.

    METHODS rba_Nfmetallitms FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_h\Nfmetallitms FULL result_requested RESULT result LINK association_links.

    METHODS rba_Return FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_h\Return FULL result_requested RESULT result LINK association_links.

    METHODS rba_Success FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_h\Success FULL result_requested RESULT result LINK association_links.

    METHODS rba_Textdatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_h\Textdatain FULL result_requested RESULT result LINK association_links.

    METHODS cba_Billingdatain FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_bl_h\Billingdatain.

    METHODS cba_Ccarddatain FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_bl_h\Ccarddatain.

    METHODS cba_Conditiondatain FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_bl_h\Conditiondatain.

    METHODS cba_Errors FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_bl_h\Errors.

    METHODS cba_Nfmetallitms FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_bl_h\Nfmetallitms.

    METHODS cba_Return FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_bl_h\Return.

    METHODS cba_Success FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_bl_h\Success.

    METHODS cba_Textdatain FOR MODIFY
      IMPORTING entities_cba FOR CREATE /zuora001/r_bl_h\Textdatain.

 TYPES: BEGIN OF e_msg,
             message TYPE string,
             inv_no  TYPE /zuora001/t_bl_h-bl_doc_number,
           END OF e_msg.

  METHODS:
      get_next_id
        RETURNING VALUE(rv_id) TYPE sysuuid_x16
        RAISING   cx_uuid_error ,
      get_next_invoice_id
        RETURNING VALUE(rv_inv_id) TYPE /zuora001/t_bl_h-bl_doc_number,
        Post_Invoice
        EXPORTING e_msg TYPE e_msg
        RAISING   cx_uuid_error . "string.


ENDCLASS.

CLASS lhc_R_BL_H IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

    CLEAR:customer_id,destination_name,destination_system,gv_je_user_name,gv_id,gv_uuid .
    GET TIME STAMP FIELD gv_timestamp1.
    CONVERT TIME STAMP gv_timestamp1 TIME ZONE 'UTC' INTO DATE DATA(gv_start_date) TIME DATA(gv_start_time).
*    gv_start_time = sy-uzeit.
*  * Read Entity from UI in table after filling all entries and press CREATE button
    "--Mapping is required for this CORRESPONDING in behavior CDS--DB in BH_Def.
    gt_invoice_h = VALUE #(
  FOR wa_entity IN entities
    (
      je_uid            = wa_entity-je_uid
      customer_id       = wa_entity-customer_id
      bl_doc_number     = ''
      destination_system = wa_entity-destination_system
      destination_name  = wa_entity-destination_name
      land_scape        = wa_entity-land_scape
      created_by        = wa_entity-created_by
      created_on        = wa_entity-created_on
      testrun           = wa_entity-testrun
      Username = wa_entity-Username
      posting_type      = wa_entity-posting_type
      lastchangedat     = wa_entity-lastchangedat
      locallastchangedat = wa_entity-locallastchangedat
    )
).

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
      ls_api_call-capability_id       = '3'.
      ls_api_call-je_uid               = gv_id.
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
*&---------------------------------------------------------------------->
      mapped = VALUE #(
        /zuora001/r_bl_h  = VALUE #( FOR ls_entity IN entities
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

  METHOD rba_Billingdatain.
  ENDMETHOD.

  METHOD rba_Ccarddatain.
  ENDMETHOD.

  METHOD rba_Conditiondatain.
  ENDMETHOD.

  METHOD rba_Errors.
  ENDMETHOD.

  METHOD rba_Nfmetallitms.
  ENDMETHOD.

  METHOD rba_Return.
  ENDMETHOD.

  METHOD rba_Success.
  ENDMETHOD.

  METHOD rba_Textdatain.
  ENDMETHOD.

  METHOD cba_Billingdatain.
    gt_invoice_i = VALUE #(
      FOR ls_entity_cba IN entities_cba
      FOR ls_item_cba IN ls_entity_cba-%target INDEX INTO idx
      LET ls_rap_items = CORRESPONDING /zuora001/t_BL_I( ls_item_cba MAPPING FROM ENTITY )
      IN (
            je_uid               = gv_id
            customer_id          = customer_id
            destination_system   = destination_name
            destination_name     = destination_system
            itemno_acc = idx
            salesorg             = ls_item_cba-salesorg
            distr_chan           = ls_item_cba-distr_chan
            division             = ls_item_cba-division
            doc_type             = ls_item_cba-doc_type
            ordbilltyp           = ls_item_cba-ordbilltyp
            bill_date            = ls_item_cba-bill_date
            sold_to              = ls_item_cba-sold_to
            item_categ           = ls_item_cba-item_categ
            acctasgnmt           = ls_item_cba-acctasgnmt
            price_date           = ls_item_cba-price_date
            country              = ls_item_cba-country
            plant                = ls_item_cba-plant
            bill_to              = ls_item_cba-bill_to
            payer                = ls_item_cba-payer
            ship_to              = ls_item_cba-ship_to
            ref_doc              = ls_item_cba-ref_doc
            material             = ls_item_cba-material
            req_qty              = ls_item_cba-req_qty
            currency             = ls_item_cba-currency
            short_text           = ls_item_cba-short_text
            taxcl_1mat           = ls_item_cba-taxcl_1mat
            ref_item             = ls_item_cba-ref_item
            stat_group           = ls_item_cba-stat_group
            no_matmast           = ls_item_cba-no_matmast
            addr_no              = ls_item_cba-addr_no
            title                = ls_item_cba-title
            name                 = ls_item_cba-name
            name_2               = ls_item_cba-name_2
            postl_code           = ls_item_cba-postl_code
            consumctry           = ls_item_cba-consumctry
            city                 = ls_item_cba-city
            district             = ls_item_cba-district
            street               = ls_item_cba-street
            region               = ls_item_cba-region
            prod_hier            = ls_item_cba-prod_hier
            sales_unit           = ls_item_cba-sales_unit
            profit_ctr           = ls_item_cba-profit_ctr
            taxjurcode           = ls_item_cba-taxjurcode
            purch_ord            = ls_item_cba-purch_ord
            doc_number           = ls_item_cba-doc_number
            itm_number           = ls_item_cba-itm_number
            origindoc            = ls_item_cba-origindoc
            item                 = ls_item_cba-item
            created_by           = ls_item_cba-created_by
            material_external    = ls_item_cba-material_external
            material_guid        = ls_item_cba-material_guid
            material_version     = ls_item_cba-material_version
            incoterms1           = ls_item_cba-incoterms1
            incoterms2           = ls_item_cba-incoterms2
            exchange_rate        = ls_item_cba-exchange_rate
            payment_terms        = ls_item_cba-payment_terms
            hg_lv_item           = ls_item_cba-hg_lv_item
            ref_doc_ca           = ls_item_cba-ref_doc_ca
            orderid              = ls_item_cba-orderid
            profit_segm_no       = ls_item_cba-profit_segm_no
            costcenter           = ls_item_cba-costcenter
            wbs_elem             = ls_item_cba-wbs_elem
            tax_depart_cty       = ls_item_cba-tax_depart_cty
            tax_dest_cty         = ls_item_cba-tax_dest_cty
            serv_date            = ls_item_cba-serv_date
            cont_acct            = ls_item_cba-cont_acct
            parallel_qty         = ls_item_cba-parallel_qty
            parallel_uom         = ls_item_cba-parallel_uom
            ref_doc_ca_long      = ls_item_cba-ref_doc_ca_long
            incotermsv           = ls_item_cba-incotermsv
            incoterms2l          = ls_item_cba-incoterms2l
            incoterms3l          = ls_item_cba-incoterms3l
            material_long        = ls_item_cba-material_long
          )
    ).
  ENDMETHOD.

  METHOD cba_Ccarddatain.
  gt_invoice_v = VALUE #(
    FOR ls_entity_cba IN entities_cba
      FOR ls_card_cba IN ls_entity_cba-%target INDEX INTO idx
        (
          je_uid           = gv_id
          itemno_acc = idx
          bl_doc_number    = ls_card_cba-bl_doc_number
          customer_id          = customer_id
          destination_system   = destination_name
          destination_name     = destination_system
          land_scape       = ls_card_cba-land_scape
          paytype          = ls_card_cba-paytype
          cc_type          = ls_card_cba-cc_type
          cc_number        = ls_card_cba-cc_number
          cc_seq_no        = ls_card_cba-cc_seq_no
          cc_valid_f       = ls_card_cba-cc_valid_f
          cc_valid_t       = ls_card_cba-cc_valid_t
          cc_name          = ls_card_cba-cc_name
          authamount       = ls_card_cba-authamount
          currency         = ls_card_cba-currency
          currency_iso     = ls_card_cba-currency_iso
          auth_flag        = ls_card_cba-auth_flag
          auth_date        = ls_card_cba-auth_date
          auth_time        = ls_card_cba-auth_time
          cc_auth_no       = ls_card_cba-cc_auth_no
          auth_refno       = ls_card_cba-auth_refno
          merchidcl        = ls_card_cba-merchidcl
          terminal         = ls_card_cba-terminal
          dataorigin       = ls_card_cba-dataorigin
          cc_settled       = ls_card_cba-cc_settled
          cc_loc_id        = ls_card_cba-cc_loc_id
          bill_plan        = ls_card_cba-bill_plan
          bill_plani       = ls_card_cba-bill_plani
          bill_value       = ls_card_cba-bill_value
          cc_token         = ls_card_cba-cc_token
          ref_doc          = ls_card_cba-ref_doc
        )
  ).
  ENDMETHOD.

  METHOD cba_Conditiondatain.
   gt_invoice_c = VALUE #(
    FOR ls_entity_cba IN entities_cba
      FOR ls_cond_cba IN ls_entity_cba-%target
        (
          je_uid            = gv_id
          customer_id          = customer_id
          destination_system   = destination_name
          destination_name     = destination_system
          data_index        = ls_cond_cba-data_index
          cond_type         = ls_cond_cba-cond_type
          cond_value        = ls_cond_cba-cond_value
          cond_curr         = ls_cond_cba-cond_curr
          cond_p_unt        = ls_cond_cba-cond_p_unt
          cond_d_unt        = ls_cond_cba-cond_d_unt
        )
  ).

  ENDMETHOD.

  METHOD cba_Errors.
   gt_invoice_e = VALUE #(
    FOR ls_entity_cba IN entities_cba
      FOR ls_error_cba IN ls_entity_cba-%target
        (
          je_uid            = gv_id
          customer_id          = customer_id
          destination_system   = destination_name
          destination_name     = destination_system
          ref_doc           = ls_error_cba-ref_doc
          ref_doc_item      = ls_error_cba-ref_doc_item
          type              = ls_error_cba-type
          id                = ls_error_cba-id
          number_n          = ls_error_cba-number_n
          message           = ls_error_cba-message
          log_no            = ls_error_cba-log_no
          log_msg_no        = ls_error_cba-log_msg_no
          message_v1        = ls_error_cba-message_v1
          message_v2        = ls_error_cba-message_v2
          message_v3        = ls_error_cba-message_v3
          message_v4        = ls_error_cba-message_v4
        )
  ).

  ENDMETHOD.

  METHOD cba_Nfmetallitms.
  gt_invoice_n = VALUE #(
    FOR ls_entity_cba IN entities_cba
      FOR ls_nf_cba IN ls_entity_cba-%target
        (
          je_uid            = gv_id
          customer_id          = customer_id
          destination_system   = destination_name
          destination_name     = destination_system
          data_index        = ls_nf_cba-data_index
          doc_number        = ls_nf_cba-doc_number
          itm_number        = ls_nf_cba-itm_number
          compcode          = ls_nf_cba-compcode
          fiscyear          = ls_nf_cba-fiscyear
          nfmkey            = ls_nf_cba-nfmkey
          ratedetkey        = ls_nf_cba-ratedetkey
          basekey           = ls_nf_cba-basekey
          exchangekey       = ls_nf_cba-exchangekey
          ratedetdat        = ls_nf_cba-ratedetdat
          ratemonth         = ls_nf_cba-ratemonth
          actratedat        = ls_nf_cba-actratedat
          rate              = ls_nf_cba-rate
          ratecurky         = ls_nf_cba-ratecurky
          ratecurkyiso      = ls_nf_cba-ratecurkyiso
          ratedoccur        = ls_nf_cba-ratedoccur
          invoicebl         = ls_nf_cba-invoicebl
          bvaldoccur        = ls_nf_cba-bvaldoccur
          bvalcurkyd        = ls_nf_cba-bvalcurkyd
          bvalcurkydiso     = ls_nf_cba-bvalcurkydiso
          netrate           = ls_nf_cba-netrate
          provider          = ls_nf_cba-provider
          vendorcov         = ls_nf_cba-vendorcov
          coverageky        = ls_nf_cba-coverageky
          postingdays       = ls_nf_cba-postingdays
          updtype           = ls_nf_cba-updtype
        )
  ).
  ENDMETHOD.

  METHOD cba_Return.

  gt_invoice_ret = VALUE #( FOR ls_entity_cba IN entities_cba
      FOR ls_item_cba IN ls_entity_cba-%target
      LET ls_rap_ret = CORRESPONDING /zuora001/T_BL_R( ls_item_cba MAPPING FROM ENTITY )
       IN (
          je_uid            = gv_id
          customer_id       = customer_id
          bl_doc_number     = ''
          destination_system = destination_system
          destination_name  =  destination_name
          type              = ls_rap_ret-type
          id                = ls_rap_ret-id
          number_n          = ls_rap_ret-number_n
          message           = ls_rap_ret-message
          log_no            = ls_rap_ret-log_no
          log_msg_no        = ls_rap_ret-log_msg_no
          message_v1        = ls_rap_ret-message_v1
          message_v2        = ls_rap_ret-message_v2
          message_v3        = ls_rap_ret-message_v3
        )
  ).
  ENDMETHOD.

  METHOD cba_Success.
  ENDMETHOD.

  METHOD cba_Textdatain.

   gt_invoice_t = VALUE #(
    FOR ls_entity_cba IN entities_cba
      FOR ls_text_cba IN ls_entity_cba-%target
        (
          je_uid            = gv_id
          customer_id       = ls_text_cba-customer_id
          bl_doc_number     = ls_text_cba-bl_doc_number
          destination_system = ls_text_cba-destination_system
          destination_name  = ls_text_cba-destination_name
          ref_doc           = ls_text_cba-ref_doc
          ref_item          = ls_text_cba-ref_item
          applobject        = ls_text_cba-applobject
          text_id           = ls_text_cba-text_id
          langu             = ls_text_cba-langu
          format_col        = ls_text_cba-format_col
          text_line         = ls_text_cba-text_line
        )
  ).
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

  ENDMETHOD.

  METHOD post_invoice.
    DELETE gt_invoice_ret WHERE message IS INITIAL.
    IF gt_invoice_h IS NOT INITIAL.
      DATA(ls_header_check) = VALUE #( gt_invoice_h[ 1 ] OPTIONAL ).
    ENDIF.
    DATA(lo_validator)  = NEW /zuora001/bl_validation( ).
    DATA(lo_process_bl) = NEW /zuora001/process_bl( ).
    " Call the validation method
    lo_validator->validate_header( EXPORTING is_header_check = ls_header_check
                                   IMPORTING gt_invoice_ret  = gt_invoice_ret ).
    CLEAR:gv_customer_id.
    IF gt_invoice_ret[] IS INITIAL.
      lo_validator->value_mapping_transform( CHANGING is_header_check = ls_header_check
                                             it_item_record  = gt_invoice_i
                                             gt_invoice_ret  = gt_invoice_ret ).
*&----------------------------------------------------------------------------------------->
*&
      lo_process_bl->get_system_version( EXPORTING customer_id = customer_id
                                                   destination_name = destination_name
                                         CHANGING  landscape = gv_landscape ).
      IF gv_landscape = 'PRI'.
        IF gt_invoice_h IS NOT INITIAL.
          lo_process_bl->process_creatordatain(
            EXPORTING
              is_header_check =  ls_header_check
            CHANGING
              gt_invoice_h    =  gt_invoice_h
              gt_invoice_ret  =  gt_invoice_ret
              creatordatain   = creatordatain
          ).
        ENDIF.
*
*        " BILLINGDATAIN
        IF gt_invoice_i IS NOT INITIAL.
          lo_process_bl->process_billingdatain(
            EXPORTING is_header_check = ls_header_check
            CHANGING  gt_invoice_i    = gt_invoice_i
                      gt_invoice_ret  = gt_invoice_ret
                      billingdatain = billingdatain

          ).
        ENDIF.

        " CONDITIONDATAIN
        IF gt_invoice_c IS NOT INITIAL.
          lo_process_bl->process_conditiondatain(
            EXPORTING is_header_check = ls_header_check
            CHANGING  gt_invoice_c    = gt_invoice_c
                      gt_invoice_ret  = gt_invoice_ret
                      conditiondatain = conditiondatain
          ).
        ENDIF.

        " CCARDDATAIN
        IF gt_invoice_v IS NOT INITIAL.
          lo_process_bl->process_ccarddatain(
            EXPORTING is_header_check = ls_header_check
            CHANGING  gt_invoice_v    = gt_invoice_v
                      gt_invoice_ret  = gt_invoice_ret
                      ccarddatain = ccarddatain
          ).
        ENDIF.

        " TEXTDATAIN
        IF gt_invoice_t IS NOT INITIAL.
          lo_process_bl->process_textdatain(
            EXPORTING is_header_check = ls_header_check
            CHANGING  gt_invoice_t    = gt_invoice_t
                      gt_invoice_ret  = gt_invoice_ret
                      textdatain = textdatain
          ).
        ENDIF.
        " NFMETALLITMS
        IF gt_invoice_n IS NOT INITIAL.
          lo_process_bl->process_nfmetallitms(
            EXPORTING is_header_check = ls_header_check
            CHANGING  gt_invoice_n    = gt_invoice_n
                      gt_invoice_ret  = gt_invoice_ret
                      nfmetallitms = nfmetallitms
          ).
        ENDIF.
        IF gt_invoice_ret IS INITIAL.
          lo_process_bl->process_return(
            EXPORTING is_header_check = ls_header_check
            CHANGING
                      gt_invoice_ret  = gt_invoice_ret
                      return = return
          ).
        ENDIF.
        IF gt_invoice_E IS INITIAL.
          lo_process_bl->process_errors(
            EXPORTING is_header_check = ls_header_check
            CHANGING   gt_invoice_e    = gt_invoice_E
                       errors  = errors
          ).
        ENDIF.
        IF gt_invoice_s IS INITIAL.
          lo_process_bl->process_success(
            EXPORTING is_header_check = ls_header_check
            CHANGING   gt_invoice_S    = gt_invoice_S
                       success  = success
          ).
        ENDIF.
      ENDIF.
      TRY.
          CLEAR:i_name .
          i_name = destination_name.
          DATA(lo_destination) = cl_soap_destination_provider=>create_by_cloud_destination(
           i_name       =  i_name
         ).
          DATA(proxy) = NEW /zuora001/co_bl__zuora004__bil( destination = lo_destination ).
          DATA(request) = VALUE /zuora001/bl__zuora004__billi1(
                 creatordatain = creatordatain
                 billingdatain-item =  billingdatain
                 conditiondatain-item = conditiondatain
                 ccarddatain-item = ccarddatain
                 textdatain-item = textdatain
                 nfmetallitms-item = nfmetallitms
                 return-item = return
                 errors-item = errors
                 success-item =  success
                 ).
          proxy->zuora004__billing_doc_create(
          EXPORTING
            input = request
          IMPORTING
            output = DATA(response)
        ).
          LOOP AT response-return-item INTO DATA(ls_item).
            ls_ret-je_uid = gv_id.
            ls_ret-customer_id = customer_id.
            ls_ret-destination_name = destination_name.
            ls_ret-destination_system = destination_system.
            IF ls_item-type = 'S'.
              e_msg-inv_no = ls_item-message_v2+0(10).
            ENDIF.
            ls_ret-type = ls_item-type.
            ls_ret-log_msg_no = ls_item-id.
            ls_ret-number_n = ls_item-number.
            ls_ret-message = ls_item-message.
            ls_ret-message_v1 = ls_item-message_v1 .
            ls_ret-message_v2 = ls_item-message_v2 .
            ls_ret-message_v3 = ls_item-message_v3 .
            APPEND ls_ret TO gt_invoice_ret.
            CLEAR:ls_ret.
          ENDLOOP.
          LOOP AT response-errors-item INTO DATA(ls_errors_tab).
            ls_ret-je_uid = gv_id.
            ls_ret-customer_id = customer_id.
            ls_ret-destination_name = destination_name.
            ls_ret-destination_system = destination_system.
            ls_error-ref_doc      = ls_errors_tab-ref_doc.
            ls_error-ref_doc_item = ls_errors_tab-ref_doc_item.
            ls_error-type         = ls_errors_tab-type.
            ls_error-id           = ls_errors_tab-id.
            ls_error-number_N       = ls_errors_tab-number.
            ls_error-message      = ls_errors_tab-message.
            ls_error-log_no       = ls_errors_tab-log_no.
            ls_error-log_msg_no   = ls_errors_tab-log_msg_no.
            ls_error-message_v1   = ls_errors_tab-message_v1.
            ls_error-message_v2   = ls_errors_tab-message_v2.
            ls_error-message_v3   = ls_errors_tab-message_v3.
            ls_error-message_v4   = ls_errors_tab-message_v4.
            APPEND ls_error TO gt_invoice_e.
            CLEAR: ls_error.
          ENDLOOP.
          " handle response
        CATCH cx_soap_destination_error INTO DATA(soap_destination_error).
          DATA(error_message) = soap_destination_error->get_text(  ).
          ls_ret-type  = 'E'.
          ls_ret-message =  error_message.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR ls_ret.
        CATCH cx_ai_system_fault INTO DATA(ai_system_fault).
          error_message = |code: { ai_system_fault->code  } codetext: { ai_system_fault->errortext }|.
          ls_ret-message =  error_message.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR ls_ret.
        CATCH cx_http_dest_provider_error.
          " handle error
          error_message = |code: { ai_system_fault->code  } codetext: { ai_system_fault->errortext }|.
          ls_ret-type  = 'E'.
          ls_ret-message =  error_message.
          APPEND ls_ret TO gt_invoice_ret.
          CLEAR ls_ret.
      ENDTRY.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_BL_C DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_c.
    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_c.
    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_c RESULT result.
    METHODS rba_Creatordatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_c\Creatordatain FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_BL_C IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Creatordatain.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_BL_E DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_e.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_e.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_e RESULT result.

    METHODS rba_Creatordatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_e\Creatordatain FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_BL_E IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Creatordatain.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_BL_I DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_i.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_i.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_i RESULT result.

    METHODS rba_Creatordatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_i\Creatordatain FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_BL_I IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Creatordatain.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_BL_R DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_r.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_r.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_r RESULT result.

    METHODS rba_Creatordatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_r\Creatordatain FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_BL_R IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Creatordatain.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_BL_N DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_n.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_n.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_n RESULT result.

    METHODS rba_Creatordatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_n\Creatordatain FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_BL_N IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Creatordatain.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_BL_S DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_s.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_s.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_s RESULT result.

    METHODS rba_Creatordatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_s\Creatordatain FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_BL_S IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Creatordatain.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_BL_T DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_t.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_t.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_t RESULT result.

    METHODS rba_Creatordatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_t\Creatordatain FULL result_requested RESULT result LINK association_links.
    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /ZUORA001/R_BL_T.

ENDCLASS.

CLASS lhc_R_BL_T IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Creatordatain.
  ENDMETHOD.

  METHOD create.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_R_BL_V DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /zuora001/r_bl_v.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /zuora001/r_bl_v.

    METHODS read FOR READ
      IMPORTING keys FOR READ /zuora001/r_bl_v RESULT result.

    METHODS rba_Creatordatain FOR READ
      IMPORTING keys_rba FOR READ /zuora001/r_bl_v\Creatordatain FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_R_BL_V IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Creatordatain.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_R_BL_H DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_R_BL_H IMPLEMENTATION.

  METHOD finalize.
    DATA: customer_id        TYPE /zuora001/t_bl_h-customer_id,
          destination_system TYPE /zuora001/t_bl_h-destination_system,
          destination_name   TYPE /zuora001/t_bl_h-destination_name,
          gv_landscape       TYPE /zuora001/t_bl_h-land_scape.
    READ TABLE lhc_R_BL_H=>gt_invoice_h INTO DATA(is_header_check) INDEX 1.
    DATA(lo_process_bl) = NEW /zuora001/process_bl( ).
    lo_process_bl->post_invoice(
      EXPORTING
        is_header_check =  is_header_check
      CHANGING
        gt_invoice_h    = lhc_R_BL_H=>gt_invoice_h
        gt_invoice_i    = lhc_R_BL_H=>gt_invoice_i
        gt_invoice_c    = lhc_R_BL_H=>gt_invoice_c
        gt_invoice_v    = lhc_R_BL_H=>gt_invoice_v
        gt_invoice_n    = lhc_R_BL_H=>gt_invoice_n
        gt_invoice_e    = lhc_R_BL_H=>gt_invoice_e
        gt_invoice_ret  = lhc_R_BL_H=>gt_invoice_ret
        gt_invoice_s    = lhc_R_BL_H=>gt_invoice_s
        gt_invoice_t    = lhc_R_BL_H=>gt_invoice_t
    ).

  ENDMETHOD.

  METHOD check_before_save.

  ENDMETHOD.

  METHOD save.

     DATA:ls_api_call        TYPE /zuora001/t_apic,
      gv_timestamp1      TYPE timestampl,
      gv_timestamp_P     TYPE timestampl,
      gv_id              TYPE sysuuid_x16,
      gv_start_time      TYPE t,
      gv_je_end_time     TYPE t,
      gv_uuid            TYPE string,
      gv_object_key      TYPE string,
      gv_pos             TYPE i.
      GET TIME STAMP FIELD gv_timestamp1.
      CONVERT TIME STAMP gv_timestamp1 TIME ZONE 'UTC' INTO DATE DATA(gv_start_date) TIME gv_je_end_time.
      DATA(lv_count) = lines( lhc_R_BL_H=>gt_invoice_i ).  " Count the number of entries in GT_INVOICE_I
      ls_api_call-client                = sy-mandt.
      ls_api_call-capability_id       = '3'.
      ls_api_call-je_uid               = gv_id.
      ls_api_call-customer_id          = lhc_R_BL_H=>gt_invoice_h[ 1 ]-customer_id.
      ls_api_call-dsetination_system   = lhc_R_BL_H=>gt_invoice_h[ 1 ]-destination_system .
      ls_api_call-destination_name     = lhc_R_BL_H=>gt_invoice_h[ 1 ]-destination_name.
      ls_api_call-api_start_date       = gv_timestamp1.
      ls_api_call-execution_time       = ''.
      ls_api_call-api_user_id          = 'AFI_BTP'.
      ls_api_call-number_of_je_line_items = ''.
      ls_api_call-api_status           = ''.
      ls_api_call-status               = ''.
      ls_api_call-created_by = lhc_R_BL_H=>gt_invoice_h[ 1 ]-username.
      ls_api_call-created_at = gv_timestamp1.
      ls_api_call-local_changed_by      = ''.
      ls_api_call-local_last_changed_at = ''.
      ls_api_call-last_changed_at       = ''.
      ls_api_call-client                = sy-mandt.
      ls_api_call-je_uid               = lhc_R_BL_H=>gt_invoice_h[ 1 ]-je_uid.
      ls_api_call-execution_time       = ( gv_je_end_time  ) / 60.
      ls_api_call-number_of_je_line_items = lv_count.
      ls_api_call-api_status           = '201'.
      READ TABLE lhc_R_BL_H=>gt_invoice_RET INTO DATA(ls_entry) WITH KEY TYPE = 'E'.
      IF SY-SUBRC = 0.
        ls_api_call-status               = 'E'.
      ELSE.
        ls_api_call-status               = 'S'.
      ENDIF.
      GET TIME STAMP FIELD gv_timestamp_P.
      ls_api_call-created_at = gv_timestamp_P.
      ls_api_call-posting_type = 'P'.
      ls_api_call-local_changed_by      = sy-uname.
      ls_api_call-local_last_changed_at = gv_timestamp_P.
      ls_api_call-last_changed_at       = gv_timestamp_P.
      MODIFY /zuora001/t_apic FROM @ls_api_call.

    IF NOT lhc_R_BL_H=>gt_invoice_h IS INITIAL.
      MODIFY /zuora001/t_bl_h FROM TABLE @lhc_R_BL_H=>gt_invoice_h.
    ENDIF.
    " Save Items
    IF NOT lhc_R_BL_H=>gt_invoice_i IS INITIAL.
      MODIFY /zuora001/t_bl_i FROM TABLE @lhc_R_BL_H=>gt_invoice_i.
    ENDIF.
    " Save Conditions
    IF NOT lhc_R_BL_H=>gt_invoice_c IS INITIAL.
      MODIFY /zuora001/t_bl_c FROM TABLE @lhc_R_BL_H=>gt_invoice_c.
    ENDIF.
    " Save Card Data
    IF NOT lhc_R_BL_H=>gt_invoice_v IS INITIAL.
      MODIFY /zuora001/t_bl_v FROM TABLE @lhc_R_BL_H=>gt_invoice_v.
    ENDIF.
    " Save NFM Items
    IF NOT lhc_R_BL_H=>gt_invoice_n IS INITIAL.
      MODIFY /zuora001/t_bl_n FROM TABLE @lhc_R_BL_H=>gt_invoice_n.
    ENDIF.
    " Save Errors
    IF NOT lhc_R_BL_H=>gt_invoice_e IS INITIAL.
      MODIFY /zuora001/t_bl_e FROM TABLE @lhc_R_BL_H=>gt_invoice_e.
    ENDIF.
    " Save Returns
    IF NOT lhc_R_BL_H=>gt_invoice_ret IS INITIAL.
      MODIFY /zuora001/t_bl_r FROM TABLE @lhc_R_BL_H=>gt_invoice_ret.
    ENDIF.
    " Save Success Items
    IF NOT lhc_R_BL_H=>gt_invoice_s IS INITIAL.
      MODIFY /zuora001/t_bl_s FROM TABLE @lhc_R_BL_H=>gt_invoice_s.
    ENDIF.
    " Save Texts
    IF NOT lhc_R_BL_H=>gt_invoice_t IS INITIAL.
      MODIFY /zuora001/t_bl_t FROM TABLE @lhc_R_BL_H=>gt_invoice_t.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
