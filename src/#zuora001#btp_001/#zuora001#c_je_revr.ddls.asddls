@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View For Reverse JE Return'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_JE_REVR 
as projection on /ZUORA001/R_JE_REVR
{
    key Je_Uid,
    key JeDocNumber,
    key itemno_acc,
    key customer_id,
    key Message,
    destination_system,
    destination_name,
    Type,
    ResId,
    ResNumber,
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
    documentheader : redirected to parent /ZUORA001/C_JE_REVH
}
where Message is not initial;
