@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for CommStruct TxtBill'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/C_BL_TG
  as projection on /ZUORA001/I_BL_TG
{
  key JeUid,
  key CustomerId,
  key BlDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      RefDoc,
      RefItem,
      Applobject,
      TextId,
      Langu,
      FormatCol,
      TextLine,
      /* Associations */
      _CREATORDATAIN : redirected to parent /ZUORA001/C_BL_HG
}
