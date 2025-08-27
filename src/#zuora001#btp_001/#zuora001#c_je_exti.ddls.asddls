@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EXTENSION2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_JE_EXTI 
as projection on /ZUORA001/R_JE_EXTI
{
    key je_uid,
    key customer_id,
    key JeDocNumber,
    key ItemnoAcc,
    destination_system,
    destination_name,
    Structure,
    Valuepart1,
    Valuepart2,
    Valuepart3,
    Valuepart4,
    DOCUMENTHEADER : redirected to parent /ZUORA001/C_JE_H
}
