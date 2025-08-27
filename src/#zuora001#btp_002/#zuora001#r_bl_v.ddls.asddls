@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for Method of Payment to be Processed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_BL_V as select from /zuora001/t_bl_v
      association to parent /ZUORA001/R_BL_H as CREATORDATAIN
  on $projection.je_uid = CREATORDATAIN.je_uid
    and $projection.customer_id =  CREATORDATAIN.customer_id
//    and $projection.bl_doc_number =  CREATORDATAIN.bl_doc_number
{
    key je_uid as je_uid,
    key customer_id as customer_id,
    bl_doc_number as bl_doc_number,
    destination_system as  destination_system,
    destination_name as destination_name ,
    land_scape as Land_Scape,
        paytype       AS PAYTYPE,
    cc_type       AS CC_TYPE,
    cc_number     AS CC_NUMBER,
    cc_seq_no     AS CC_SEQ_NO,
    cc_valid_f    AS CC_VALID_F,
    cc_valid_t    AS CC_VALID_T,
    cc_name       AS CC_NAME,
    authamount    AS AUTHAMOUNT,
    currency      AS CURRENCY,
    currency_iso  AS CURRENCY_ISO,
    auth_flag     AS AUTH_FLAG,
    auth_date     AS AUTH_DATE,
    auth_time     AS AUTH_TIME,
    cc_auth_no    AS CC_AUTH_NO,
    auth_refno    AS AUTH_REFNO,
    merchidcl     AS MERCHIDCL,
    terminal      AS TERMINAL,
    dataorigin    AS DATAORIGIN,
    cc_settled    AS CC_SETTLED,
    cc_loc_id     AS CC_LOC_ID,
    bill_plan     AS BILL_PLAN,
    bill_plani    AS BILL_PLANI,
    bill_value    AS BILL_VALUE,
    cc_token      AS CC_TOKEN,
    ref_doc       AS REF_DOC,

     CREATORDATAIN
}
