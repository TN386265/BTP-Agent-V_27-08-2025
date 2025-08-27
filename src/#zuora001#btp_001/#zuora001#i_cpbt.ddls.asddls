//@AbapCatalog.sqlViewName: '/ZUORA001/VICPBT'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true

@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for Capability Master'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity /ZUORA001/I_CPBT
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
