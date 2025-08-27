@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AccountTax'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_JE_T 
as projection on /ZUORA001/R_JE_T

{
    key je_uid,
    key customer_id,
    key JeDocNumber,
    key ItemnoAcc,
    destination_system,
    destination_name,
    GlAccount,
    CondKey,
    AcctKey,
    TaxCode,
    TaxRate,
    TaxDate,
    Taxjurcode,
    TaxjurcodeDeep,
    TaxjurcodeLevel,
    ItemnoTax,
    DirectTax,
    DOCUMENTHEADER : redirected to parent /ZUORA001/C_JE_H
}
