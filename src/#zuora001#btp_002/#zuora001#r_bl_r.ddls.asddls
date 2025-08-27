@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for Processing Errors'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_BL_R
  as select from /zuora001/t_bl_r
        association to parent /ZUORA001/R_BL_H as CREATORDATAIN
  on $projection.je_uid = CREATORDATAIN.je_uid
    and $projection.customer_id =  CREATORDATAIN.customer_id
//    and $projection.bl_doc_number =  CREATORDATAIN.bl_doc_number
{
    key je_uid as je_uid,
    key customer_id as customer_id,
    key message            as Message,
    bl_doc_number as bl_doc_number,
    destination_system as  destination_system,
    destination_name as destination_name ,
//    land_scape as Land_Scape,
      type               as type,
      id                 as id,
      number_n           as number_n,
      log_no             as log_no,
      log_msg_no         as log_msg_no,
      message_v1         as message_v1,
      message_v2         as message_v2,
      message_v3         as message_v3,
      CREATORDATAIN

} where message is not initial;
