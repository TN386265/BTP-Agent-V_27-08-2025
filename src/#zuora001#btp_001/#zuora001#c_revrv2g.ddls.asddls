@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for Reversal Return'
@Metadata.ignorePropagatedAnnotations: true

define view entity /ZUORA001/C_REVRV2G
  as projection on /ZUORA001/I_REVRV2G
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
      _apic : redirected to parent /ZUORA001/C_APICEG
}
