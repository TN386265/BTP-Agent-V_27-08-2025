@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_JE_EXTH
  as projection on /ZUORA001/R_JE_EXTH
{
    key je_uid,
    key customer_id,
    key JeDocNumber,
    key ItemnoAcc,
    destination_system,
    destination_name,
    Field1,
    Field2,
    Field3,
    Field4,
    DOCUMENTHEADER : redirected to parent /ZUORA001/C_JE_H
}
