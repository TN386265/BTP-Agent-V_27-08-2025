@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Reversal Return'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define view entity /ZUORA001/I_REVRV2G
  as select from /ZUORA001/I_REVRV2
  association to parent /ZUORA001/I_APICEG as _apic on  $projection.CustomerId  = _apic.CustomerId
                                                    and $projection.JeUid       = _apic.JeUid
                                                    and $projection.JeDocNumber = _apic.JeDocNumber
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

      _apic
}
