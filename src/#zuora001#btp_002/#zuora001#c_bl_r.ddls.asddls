@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for Processing Errors'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_BL_R as projection on /ZUORA001/R_BL_R
{
   key je_uid,
   key customer_id,
   key Message,
   bl_doc_number,
    destination_system,
    destination_name,   
    type,
    id,
    number_n,
    log_no,
    log_msg_no,
    message_v1,
    message_v2,
    message_v3,
   CREATORDATAIN: redirected to parent /ZUORA001/C_BL_H
}
