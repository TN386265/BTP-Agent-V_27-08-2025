@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View for Mapping Table'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/R_JE_MAPC
  as select from /zuora001/t_mapc
{
  key customer_id           as CustomerId,
  key destination_name      as DestinationName,
  key capability_id         as CapabilityId,
  key rule_id               as RuleId,
  key condition_seq         as ConditionSeq,
  key target_seq            as TargetSeq,
      rule_description      as Ruledescription,
      obj_type              as ObjType,
      source_field          as SourceField,
      source_value          as SourceValue,
      value_type            as ValueType,
      range_end_value       as RangeEndValue,
      target_field          as TargetField,
      target_value          as TargetValue,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
