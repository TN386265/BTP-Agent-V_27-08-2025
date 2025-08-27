@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value mapping JSON interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity /ZUORA001/I_MAPU
  as select from /zuora001/t_mapu
{
  key customer_id           as CustomerId,
  key rule_id               as RuleId,
      source_data           as SourceData,
      target_data           as TargetData,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
