@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for Field Mappings'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/I_MAPC
  as select from /zuora001/t_mapc
{
  key customer_id           as CustomerId,
  key destinationid         as Destinationid,
  key destination_name      as DestinationName,
  key capability_id         as CapabilityId,
  key rule_id               as RuleId,
  key condition_seq         as ConditionSeq,
  key target_seq            as TargetSeq,
  key valid_from            as ValidFrom,
      valid_to              as ValidTo,
      rule_description      as RuleDescription,
      source_field          as SourceField,
      target_field          as TargetField,
      mapping_type          as MappingType,
      obj_type              as ObjType,
      source_value          as SourceValue,
      value_type            as ValueType,
      range_end_value       as RangeEndValue,
      target_value          as TargetValue,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
