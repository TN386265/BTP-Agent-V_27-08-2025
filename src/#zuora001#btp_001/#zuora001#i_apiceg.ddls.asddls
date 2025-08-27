@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Reversal API'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define root view entity /ZUORA001/I_APICEG
  as select from /ZUORA001/I_APICE
  composition [1..1] of /ZUORA001/I_REVHV2G as _revh
  composition [0..*] of /ZUORA001/I_REVRV2G as _revr
{
  key JeUid,
  key CustomerId,
  key JeDocNumber,
      CapabilityId,
      CapabilityName,
      DsetinationSystem,
      DestinationName,
      ApiStartDate,
      ExecutionTime,
      ApiUserId,
      NumberOfJeLineItems,
      ApiStatus,
      PostingType,
      PostingTypeDescr,
      LandScape,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      _revh,

      _revr
}
