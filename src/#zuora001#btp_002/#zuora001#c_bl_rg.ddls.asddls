@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for Return Parameter'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/C_BL_RG
  as projection on /ZUORA001/I_BL_RG
{
  key JeUid,
  key CustomerId,
  key BlDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      Type,
      Id,
      NumberN,
      Message,
      LogNo,
      LogMsgNo,
      MessageV1,
      MessageV2,
      MessageV3,
      /* Associations */
      _CREATORDATAIN : redirected to parent /ZUORA001/C_BL_HG
}
