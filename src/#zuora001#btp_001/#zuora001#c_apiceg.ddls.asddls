@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for Reversal API'
@Metadata.ignorePropagatedAnnotations: true

define root view entity /ZUORA001/C_APICEG
  provider contract transactional_query
  as projection on /ZUORA001/I_APICEG
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

      /* Associations */
      _revh : redirected to composition child /ZUORA001/C_REVHV2G,
      _revr : redirected to composition child /ZUORA001/C_REVRV2G
}
