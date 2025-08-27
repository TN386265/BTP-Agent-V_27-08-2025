@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for Value Mapping'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/I_MAPV
  as select from /zuora001/t_mapv
{
  key customer_id           as CustomerId,
  key rule_id               as RuleId,
  key condition_seq         as ConditionSeq,
  key target_seq            as TargetSeq,
  key value_id              as ValueId,
  key valid_from            as ValidFrom,
      valid_to              as ValidTo,
      source_value          as SourceValue,
      target_value          as TargetValue,
      source_condition      as SourceCondition,
      target_condition      as TargetCondition,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
