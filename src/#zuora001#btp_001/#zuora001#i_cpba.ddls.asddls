@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for Capabilities of a Customer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_CPBA
  with parameters
    p_custid : /zuora001/decustomerid
  as select from /zuora001/t_cpbc
{
  key capability_id         as CapabilityId,
  key customer_id           as CustomerId,
  key valid_from            as ValidFrom,
      valid_to              as ValidTo,
      activated_date        as ActivatedDate,
      expiry_date           as ExpiryDate,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
where
      customer_id = $parameters.p_custid
