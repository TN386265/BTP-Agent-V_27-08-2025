@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Information on Incorrect Processing of Preceding Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_BL_E
  as select from /zuora001/t_bl_e
       association to parent /ZUORA001/R_BL_H as CREATORDATAIN
  on $projection.je_uid = CREATORDATAIN.je_uid
    and $projection.customer_id =  CREATORDATAIN.customer_id
//    and $projection.bl_doc_number =  CREATORDATAIN.bl_doc_number

{
  key je_uid             as je_uid,
  key customer_id        as customer_id,
      bl_doc_number      as bl_doc_number,
      destination_system as destination_system,
      destination_name   as destination_name,
      ref_doc            as ref_doc,
      ref_doc_item       as ref_doc_item,
      type               as type,
      id                 as id,
      number_n           as number_n,
      message            as message,
      log_no             as log_no,
      log_msg_no         as log_msg_no,
      message_v1         as message_v1,
      message_v2         as message_v2,
      message_v3         as message_v3,
      message_v4         as message_v4,
      CREATORDATAIN

} where message is not initial;
