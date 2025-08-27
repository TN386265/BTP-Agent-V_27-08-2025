CLASS /zuora001/process_bl DEFINITION
   PUBLIC

  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    TYPES: billingdatain   TYPE STANDARD TABLE OF /zuora001/blbapivbrk,          " BAPIVBRK
           conditiondatain TYPE STANDARD TABLE OF /zuora001/blbapikomv,          " BAPIKOMV
           ccarddatain     TYPE STANDARD TABLE OF /zuora001/blbapiccard_vf,      " BAPICCARD_VF
           textdatain      TYPE STANDARD TABLE OF /zuora001/blbapikomfktx,       " BAPIKOMFKTX
           errors          TYPE STANDARD TABLE OF /zuora001/blbapivbrkerrors,    " BAPIVBRKERRORS
           return          TYPE STANDARD TABLE OF /zuora001/blbapiret1,          " BAPIRET1
           success         TYPE STANDARD TABLE OF /zuora001/blbapivbrksuccess,   " BAPIVBRKSUCCESS
           nfmetallitms    TYPE STANDARD TABLE OF /zuora001/bl__nfm__bapidocitm. " /NFM/BAPIDOCITM

    TYPES:  creatordatain    TYPE /zuora001/blbapicreatordata.                     " CREATORDATAIN

    TYPES:
      gt_invoice_h   TYPE STANDARD TABLE OF /zuora001/t_bl_h,
      gt_invoice_i   TYPE STANDARD TABLE OF /zuora001/t_bl_i,
      gt_invoice_c   TYPE STANDARD TABLE OF /zuora001/t_bl_c,
      gt_invoice_v   TYPE STANDARD TABLE OF /zuora001/t_bl_v,
      gt_invoice_t   TYPE STANDARD TABLE OF /zuora001/t_bl_t,
      gt_invoice_e   TYPE STANDARD TABLE OF /zuora001/t_bl_e,
      gt_invoice_ret TYPE STANDARD TABLE OF /zuora001/t_bl_r,
      gt_invoice_s   TYPE STANDARD TABLE OF /zuora001/t_bl_s,
      gt_invoice_n   TYPE STANDARD TABLE OF /zuora001/t_bl_n.

    CONSTANTS :gv_active TYPE /zuora001/i_cust-Status VALUE '1'.

    DATA:ls_ret              TYPE /zuora001/t_bl_r,
         gv_customer_id      TYPE /zuora001/decustomerid,
         gv_destination_name TYPE /zuora001/t_dest-destination_name.

    DATA:gt_Customer_master TYPE STANDARD TABLE OF /zuora001/i_cust,
         gt_dest_master     TYPE STANDARD TABLE OF /zuora001/i_dest,
         gt_VALUE_MAPPING   TYPE STANDARD TABLE OF /zuora001/c_je_mapc.
    METHODS get_system_version
      IMPORTING REFERENCE(customer_id)      TYPE  /zuora001/t_bl_h-customer_id
                REFERENCE(destination_name) TYPE /zuora001/t_bl_h-destination_name
      CHANGING  REFERENCE(landscape)        TYPE /zuora001/t_bl_h-land_scape.

    METHODS process_billingdatain
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_i    TYPE gt_invoice_i
                gt_invoice_ret  TYPE gt_invoice_ret
                billingdatain   TYPE billingdatain.

    METHODS process_conditiondatain
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_c    TYPE gt_invoice_c
                gt_invoice_ret  TYPE gt_invoice_ret
                conditiondatain TYPE conditiondatain.

    METHODS process_ccarddatain
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_v    TYPE gt_invoice_v
                gt_invoice_ret  TYPE gt_invoice_ret
                ccarddatain     TYPE ccarddatain.

    METHODS process_textdatain
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_t    TYPE gt_invoice_t
                gt_invoice_ret  TYPE gt_invoice_ret
                textdatain      TYPE textdatain.

    METHODS process_errors
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_e    TYPE gt_invoice_e
                errors          TYPE errors.

    METHODS process_return
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_ret  TYPE gt_invoice_ret
                return          TYPE return.

    METHODS process_success
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_s    TYPE gt_invoice_s
                success         TYPE success.

    METHODS process_nfmetallitms
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_n    TYPE gt_invoice_n
                gt_invoice_ret  TYPE gt_invoice_ret
                nfmetallitms    TYPE nfmetallitms.


    METHODS process_creatordatain
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING  gt_invoice_h    TYPE gt_invoice_h
                gt_invoice_ret  TYPE gt_invoice_ret
                creatordatain   TYPE creatordatain.

    METHODS post_invoice
      IMPORTING is_header_check TYPE /zuora001/t_bl_h
      CHANGING
                gt_invoice_h    TYPE  gt_invoice_h
                gt_invoice_i    TYPE gt_invoice_i
                gt_invoice_c    TYPE   gt_invoice_c
                gt_invoice_v    TYPE  gt_invoice_v
                gt_invoice_n    TYPE gt_invoice_n
                gt_invoice_e    TYPE  gt_invoice_e
                gt_invoice_ret  TYPE gt_invoice_ret
                gt_invoice_s    TYPE gt_invoice_s
                gt_invoice_t    TYPE gt_invoice_t.

PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/PROCESS_BL IMPLEMENTATION.


  METHOD GET_SYSTEM_VERSION.
  SELECT SINGLE FROM /ZUORA001/I_DEST FIELDS landscape
       WHERE customerid    = @customer_id
         AND DestinationName = @destination_name
         AND Status = @gv_active
       INTO @landscape.
  ENDMETHOD.


  METHOD post_invoice.

    DATA:customer_id        TYPE /zuora001/t_bl_h-customer_id,
         destination_system TYPE /zuora001/t_bl_h-destination_system,
         destination_name   TYPE /zuora001/t_bl_h-destination_name,
         gv_invoice         TYPE /zuora001/t_bl_h-bl_doc_number,
         gv_landscape       TYPE /zuora001/t_bl_h-land_scape.

    DATA: lv_URL        TYPE string,
          lv_URL_S4     TYPE string,
          i_name        TYPE string,
          lv_out_string TYPE string.

    DATA: billingdatain   TYPE STANDARD TABLE OF /zuora001/blbapivbrk,          " BAPIVBRK
          conditiondatain TYPE STANDARD TABLE OF /zuora001/blbapikomv,          " BAPIKOMV
          ccarddatain     TYPE STANDARD TABLE OF /zuora001/blbapiccard_vf,      " BAPICCARD_VF
          textdatain      TYPE STANDARD TABLE OF /zuora001/blbapikomfktx,       " BAPIKOMFKTX
          errors          TYPE STANDARD TABLE OF /zuora001/blbapivbrkerrors,    " BAPIVBRKERRORS
          return          TYPE STANDARD TABLE OF /zuora001/blbapiret1,          " BAPIRET1
          success         TYPE STANDARD TABLE OF /zuora001/blbapivbrksuccess,   " BAPIVBRKSUCCESS
          nfmetallitms    TYPE STANDARD TABLE OF /zuora001/bl__nfm__bapidocitm, " /NFM/BAPIDOCITM
          creatordatain   TYPE /zuora001/blbapicreatordata.

    TYPES: BEGIN OF e_msg,
             message TYPE string,
             inv_no  TYPE /zuora001/t_bl_h-bl_doc_number,
           END OF e_msg.
    DATA:gv_id              TYPE sysuuid_x16.
    DATA:ls_error   TYPE /zuora001/t_bl_e,
         ls_success TYPE /zuora001/t_bl_s.

    DATA: ls_api_call    TYPE /zuora001/t_apic,
          gv_timestamp1  TYPE timestampl,
          gv_timestamp_P TYPE timestampl.

    customer_id =  gt_invoice_h[ 1 ]-customer_id.
    gv_id = gt_invoice_h[ 1 ]-je_uid.
    destination_name = gt_invoice_h[ 1 ]-destination_name.
    destination_system = gt_invoice_h[ 1 ]-destination_system.

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

        TRY.
            CLEAR:i_name .
            i_name = destination_name.
            DATA(lo_destination) = cl_soap_destination_provider=>create_by_cloud_destination(
             i_name       =  i_name
           ).
            DATA(proxy) = NEW /zuora001/co_bl__zuora004__bil( destination = lo_destination ).

*         creatordatain-created_by =   gt_invoice_h[ 1 ]-created_by.
*         creatordatain-created_on =   gt_invoice_h[ 1 ]-created_on.


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
              ls_ret-type = ls_item-type.
              IF ls_ret-type = 'S'.
                ls_ret-bl_doc_number = ls_item-message_v1+0(10).
              ENDIF.
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
              ls_error-je_uid = gv_id.
              ls_error-customer_id = customer_id.
              ls_error-destination_name = destination_name.
              ls_error-destination_system = destination_system.
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
            LOOP AT response-success-item INTO DATA(ls_success_tab).
              ls_success-je_uid             = gv_id.
              ls_success-customer_id        = customer_id.
              ls_success-destination_name   = destination_name.
              ls_success-destination_system = destination_system.
              ls_success-ref_doc            = ls_success_tab-ref_doc.
              ls_success-ref_doc_item       = ls_success_tab-ref_doc_item.
              ls_success-bill_doc           = ls_success_tab-bill_doc.
              ls_success-bill_doc_item      = ls_success_tab-bill_doc_item.
              ls_success-net_value          = ls_success_tab-net_value.
              ls_success-tax_value          = ls_success_tab-tax_value.
              ls_success-currency           = ls_success_tab-currency.
              ls_success-currency_iso       = ls_success_tab-currency_iso.
              ls_success-net_value_item     = ls_success_tab-net_value_item.
              ls_success-tax_value_item     = ls_success_tab-tax_value_item.
              ls_success-gro_value_item     = ls_success_tab-gro_value_item.
              APPEND ls_success TO gt_invoice_s.
              CLEAR: ls_success.
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
    ENDIF.
  ENDMETHOD.


  METHOD process_billingdatain.
    billingdatain = CORRESPONDING #( gt_invoice_i ).
  LOOP AT billingdatain ASSIGNING FIELD-SYMBOL(<fs_bil>).
  <fs_bil>-bill_date  = |{ CONV d( <fs_bil>-bill_date ) DATE = ISO }|.
  <fs_bil>-price_date = |{ CONV d( <fs_bil>-price_date ) DATE = ISO }|.
  <fs_bil>-serv_date  = |{ CONV d( <fs_bil>-serv_date ) DATE = ISO }|.
ENDLOOP.


  ENDMETHOD.


  METHOD process_ccarddatain.
    ccarddatain = CORRESPONDING #( gt_invoice_v ).
    LOOP AT ccarddatain ASSIGNING FIELD-SYMBOL(<fs_card>).
      <fs_card>-cc_valid_f = |{ CONV d( <fs_card>-cc_valid_f ) DATE = ISO }|.
      <fs_card>-cc_valid_t = |{ CONV d( <fs_card>-cc_valid_t ) DATE = ISO }|.
      <fs_card>-auth_date  = |{ CONV d( <fs_card>-auth_date ) DATE = ISO }|.
    ENDLOOP.

  ENDMETHOD.


  METHOD PROCESS_CONDITIONDATAIN.
  conditiondatain = CORRESPONDING #( gt_invoice_c ).
  ENDMETHOD.


  METHOD process_creatordatain.
    MOVE-CORRESPONDING is_header_check TO creatordatain.
  ENDMETHOD.


  METHOD process_errors.

    DATA: ls_errors TYPE /zuora001/blbapivbrkerrors.

    DO 2 TIMES.
      CLEAR ls_errors.
      IF sy-index = 1.
        ls_errors-ref_doc      = 'REFDOC001'.
        ls_errors-ref_doc_item = '000001'.
        ls_errors-type         = 'S'.
        ls_errors-id           = 'ZUORA_MSG_OK'.
        ls_errors-number       = '001'.
        ls_errors-message      = 'Document posted successfully'.
        ls_errors-log_no       = 'LOG0001'.
        ls_errors-log_msg_no   = '000001'.
        ls_errors-message_v1   = 'POSTED'.
        ls_errors-message_v2   = 'SUCCESS'.
        ls_errors-message_v3   = 'INFO'.
        ls_errors-message_v4   = 'NONE'.
      ELSE.
        ls_errors-ref_doc      = 'REFDOC002'.
        ls_errors-ref_doc_item = '000002'.
        ls_errors-type         = 'E'.
        ls_errors-id           = 'ZUORA_ERR_ID'.
        ls_errors-number       = '902'.
        ls_errors-message      = 'Error during billing document creation'.
        ls_errors-log_no       = 'LOG0002'.
        ls_errors-log_msg_no   = '000902'.
        ls_errors-message_v1   = 'INVALID DATA'.
        ls_errors-message_v2   = 'BILLING'.
        ls_errors-message_v3   = 'ERROR'.
        ls_errors-message_v4   = 'CHECK INPUT'.
      ENDIF.
      APPEND ls_errors TO errors.
    ENDDO.

  ENDMETHOD.


  METHOD process_nfmetallitms.
    nfmetallitms = CORRESPONDING #( gt_invoice_n ).
    LOOP AT nfmetallitms ASSIGNING FIELD-SYMBOL(<fs_nfm>).
      <fs_nfm>-ratedetdat  = |{ CONV d( <fs_nfm>-ratedetdat ) DATE = ISO }|.
      <fs_nfm>-actratedat  = |{ CONV d( <fs_nfm>-actratedat ) DATE = ISO }|.
    ENDLOOP.

  ENDMETHOD.


  METHOD process_return.
    return = CORRESPONDING #( gt_invoice_REt ).
    IF return[] IS INITIAL.
      DATA: ls_return TYPE /zuora001/blbapiret1.
      DO 2 TIMES.
        CLEAR ls_return.
        IF sy-index = 1.
          ls_return-type        = 'S'.
          ls_return-id          = 'Z1'.
          ls_return-number      = '001'.
          ls_return-message     = 'Dummy success message'.
          ls_return-log_no      = '0001'.
          ls_return-log_msg_no  = '000'.
          ls_return-message_v1  = 'INFO1'.
          ls_return-message_v2  = 'INFO2'.
          ls_return-message_v3  = 'INFO3'.
        ELSE.
          ls_return-type        = 'E'.
          ls_return-id          = 'Z2'.
          ls_return-number    = '002'.
          ls_return-message     = 'Dummy error message'.
          ls_return-log_no      = '0002'.
          ls_return-log_msg_no  = '001'.
          ls_return-message_v1  = 'ERR1'.
          ls_return-message_v2  = 'ERR2'.
          ls_return-message_v3  = 'ERR3'.
        ENDIF.
        APPEND ls_return TO return.
      ENDDO.
    ENDIF.
  ENDMETHOD.


  METHOD process_success.
    DATA:
          ls_success TYPE /zuora001/blBAPIVBRKSUCCESS.
    DO 2 TIMES.
      CLEAR ls_success.
      IF sy-index = 1.
        ls_success-ref_doc        = 'REFDOC001'.
        ls_success-ref_doc_item   = '000001'.
        ls_success-bill_doc       = 'BILLDOC01'.
        ls_success-bill_doc_item  = '000001'.
        ls_success-net_value      = '1500.2500'.
        ls_success-tax_value      = '100.7500'.
        ls_success-currency       = 'USD'.
        ls_success-currency_iso   = 'USD'.
        ls_success-net_value_item = '1500.2500'.
        ls_success-tax_value_item = '100.7500'.
        ls_success-gro_value_item = '1601.0000'.
      ELSE.
        ls_success-ref_doc        = 'REFDOC002'.
        ls_success-ref_doc_item   = '000002'.
        ls_success-bill_doc       = 'BILLDOC02'.
        ls_success-bill_doc_item  = '000002'.
        ls_success-net_value      = '2000.0000'.
        ls_success-tax_value      = '160.0000'.
        ls_success-currency       = 'EUR'.
        ls_success-currency_iso   = 'EUR'.
        ls_success-net_value_item = '2000.0000'.
        ls_success-tax_value_item = '160.0000'.
        ls_success-gro_value_item = '2160.0000'.
      ENDIF.
      APPEND ls_success TO success.
    ENDDO.
  ENDMETHOD.


  METHOD PROCESS_TEXTDATAIN.
textdatain = CORRESPONDING #( gt_invoice_t ).
  ENDMETHOD.
ENDCLASS.
