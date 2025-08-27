@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '/ZUORA001/C_JE_MAP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/C_JE_MAP provider contract transactional_query
as projection on /ZUORA001/R_JE_MAP
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
    LastChangedAt
}
