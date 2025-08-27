@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value mapping consumption v0'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/C_MAPC0
  provider contract transactional_query
  as projection on /ZUORA001/I_MAPC0
{
  key CustomerId,
  key Destinationid,
  key DestinationName,
  key CapabilityId,
  key RuleId,
  key ConditionSeq,
  key TargetSeq,
  key ValidFrom,
      ValidTo,
      RuleDescription,
      ActivatedDate,
      ExpiryDate,
      SourceField,
      TargetField,
      SourceValue,
      TargetValue,
      MappingType,
      SourceData,
      TargetData,
      SourceCondition,
      ObjType,
      ValueType,
      RangeEndValue,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      CreatedUserDescription,
      ChangedUserDescription
}
