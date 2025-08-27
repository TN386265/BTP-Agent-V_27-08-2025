@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for Method of Payment to be Processed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_BL_V
  as projection on /ZUORA001/R_BL_V
{
  key je_uid,
  key customer_id,
     bl_doc_number,
      destination_system,
      destination_name,
           paytype,
      cc_type,
      cc_number,
      cc_seq_no,
      cc_valid_f,
      cc_valid_t,
      cc_name,
      authamount,
      currency,
      currency_iso,
      auth_flag,
      auth_date,
      auth_time,
      cc_auth_no,
      auth_refno,
      merchidcl,
      terminal,
      dataorigin,
      cc_settled,
      cc_loc_id,
      bill_plan,
      bill_plani,
      bill_value,
      cc_token,
      ref_doc,
      CREATORDATAIN : redirected to parent /ZUORA001/C_BL_H
}
