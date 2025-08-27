@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Value Mapping'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/C_MAPV
  provider contract transactional_query
  as projection on /ZUORA001/I_MAPV as Mapv
{
  key CustomerId,
  key RuleId,
  key ConditionSeq,
  key TargetSeq,
  key ValueId,
  key ValidFrom,
      ValidTo,
      SourceValue,
      TargetValue,
      SourceCondition,
      TargetCondition,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}
