@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for Currency Interface'
@Metadata.ignorePropagatedAnnotations: true

define view entity /ZUORA001/C_JE_CG
  as projection on /ZUORA001/I_JE_CG
{
  key JeUid,
  key CustomerId,
  key JeDocNumber,
  key ItemnoAcc,
      DestinationSystem,
      DestinationName,
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
      _header : redirected to parent /ZUORA001/C_JE_HG
}
