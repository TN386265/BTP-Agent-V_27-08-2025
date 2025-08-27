@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View for Journal Currency Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_JE_C
  as projection on /ZUORA001/R_JE_C
{
  key Je_Uid,
  key customer_id,
  key JeDocNumber,
  key ItemnoAcc,
      destination_system,
      destination_name,
      CurrType,
      Currency,
      CurrencyIso,
      AmtDoccur,
      ExchRate,
      ExchRateV,
      AmtBase,
      DiscBase,
      DiscAmt,
      TaxAmt,
      /* Associations */
      documentheader : redirected to parent /ZUORA001/C_JE_H
}
