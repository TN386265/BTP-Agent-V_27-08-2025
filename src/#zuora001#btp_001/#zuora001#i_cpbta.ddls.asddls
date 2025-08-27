@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Interfac capability master - view entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_CPBTA
  as select from /zuora001/t_cpbt
{
  key capability_id         as CapabilityId,
  key valid_from            as ValidFrom,
      valid_to              as ValidTo,
      capability_name       as CapabilityName,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
