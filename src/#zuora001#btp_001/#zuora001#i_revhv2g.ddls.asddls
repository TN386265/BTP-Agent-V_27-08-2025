@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Reversal Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define view entity /ZUORA001/I_REVHV2G
  as select from /ZUORA001/I_REVHV2
  association to parent /ZUORA001/I_APICEG as _apic on  $projection.CustomerId  = _apic.CustomerId
                                                    and $projection.JeUid       = _apic.JeUid
                                                    and $projection.JeDocNumber = _apic.JeDocNumber
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

      _apic
}
