@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSOforInfo-IncorPrcsOf itm'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/C_BL_EG
  as projection on /ZUORA001/I_BL_EG
{
  key JeUid,
  key CustomerId,
  key BlDocNumber,
  key Message,
  key RefDoc,
  key RefDocItem,
      DestinationSystem,
      DestinationName,
      LandScape,


      Type,
      Id,
      NumberN,
      LogNo,
      LogMsgNo,
      MessageV1,
      MessageV2,
      MessageV3,
      MessageV4,
      /* Associations */
      _CREATORDATAIN : redirected to parent /ZUORA001/C_BL_HG
}
