@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Information on Incorrect Processing of Preceding Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_BL_E
  as projection on /ZUORA001/R_BL_E
{
  key je_uid,
  key customer_id,
      bl_doc_number,
      destination_system,
      destination_name,
      ref_doc,
      ref_doc_item,
      type,
      id,
      number_n,
      message,
      log_no,
      log_msg_no,
      message_v1,
      message_v2,
      message_v3,
      message_v4,
      CREATORDATAIN : redirected to parent /ZUORA001/C_BL_H
}
