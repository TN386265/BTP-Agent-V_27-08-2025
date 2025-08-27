@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for Return Interface'
@Metadata.ignorePropagatedAnnotations: true

define view entity /ZUORA001/C_JE_RG
  as projection on /ZUORA001/I_JE_RG
{
  key JeUid,
  key JeDocNumber,
  key ItemnoAcc,
  key CustomerId,
  key Message,
      DestinationSystem,
      DestinationName,
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
      /* Associations */
      _header : redirected to parent /ZUORA001/C_JE_HG
}
