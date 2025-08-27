@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for Reversal Header'
@Metadata.ignorePropagatedAnnotations: true

define view entity /ZUORA001/C_REVHV2G
  as projection on /ZUORA001/I_REVHV2G
{
  key JeUid,
  key CustomerId,
  key JeDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      ObjType,
      ObjKey,
      ObjSys,
      CompCode,
      Username,
      DocDate,
      PstngDate,
      ObjKeyR,
      RefDocNo,
      AcDocNo,
      ReasonRev,
      Vatdate,
      Lastchangedat,
      Locallastchangedat,

      /* Associations */
      _apic : redirected to parent /ZUORA001/C_APICEG
}
