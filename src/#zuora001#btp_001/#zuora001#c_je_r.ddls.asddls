@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View for Response'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_JE_R
  as projection on /ZUORA001/R_JE_R
{
  key  Je_Uid,
  key  JeDocNumber,
  key  itemno_acc,
  key  customer_id,
  key  Message,
       destination_system,
       destination_name,       
       ResNumber,
       ResId,
       Type,
       LogNo,
       LogMsgNo,
       MessageV1,
       MessageV2,
       MessageV3,
       MessageV4,
       ResParameter,
       ResRow,
       Field,
       ResSystem,
       /* Associations */
       documentheader : redirected to parent /ZUORA001/C_JE_H
}
where Message is not initial;
