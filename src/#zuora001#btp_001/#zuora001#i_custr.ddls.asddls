@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Customer Read only interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_CUSTR
  as select from /zuora001/t_cust
{
  key customer_id           as CustomerId,
  key valid_from            as ValidFrom,
      valid_to              as ValidTo,
      customer_name         as CustomerName,
      activated_date        as ActivatedDate,
      expiry_date           as ExpiryDate,
      active                as Active,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
