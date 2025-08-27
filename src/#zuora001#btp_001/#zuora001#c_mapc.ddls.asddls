@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Field Mapping'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #M,
    dataClass: #MIXED
}

define root view entity /ZUORA001/C_MAPC
  provider contract transactional_query
  as projection on /ZUORA001/I_MAPC
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
      SourceField,
      TargetField,
      MappingType,
      ObjType,
      SourceValue,
      ValueType,
      RangeEndValue,
      TargetValue,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}
