@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO InfoforScsPrcsBillItms'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/C_BL_SG
  as projection on /ZUORA001/I_BL_S
{
  key JeUid,
  key CustomerId,
  key BlDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      RefDoc,
      RefDocItem,
      BillDoc,
      BillDocItem,
      NetValue,
      TaxValue,
      Currency,
      CurrencyIso,
      NetValueItem,
      TaxValueItem,
      GroValueItem,
      /* Associations */
      _CREATORDATAIN : redirected to parent /ZUORA001/C_BL_HG
}
