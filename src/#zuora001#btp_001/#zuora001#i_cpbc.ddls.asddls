//@AbapCatalog.sqlViewName: '/ZUORA001/VICPBC'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true

@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for Customer Capability Link'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity /ZUORA001/I_CPBC
  as select from /zuora001/t_cpbc
  association [1..1] to /ZUORA001/I_USERS as _createdUserDetails on $projection.CreatedBy = _createdUserDetails.UserID
  association [1..1] to /ZUORA001/I_USERS as _changedUserDetails on $projection.LocalChangedBy = _changedUserDetails.UserID
{
  key capability_id                       as CapabilityId,
  key customer_id                         as CustomerId,
  key valid_from                          as ValidFrom,
      valid_to                            as ValidTo,
      activated_date                      as ActivatedDate,
      expiry_date                         as ExpiryDate,
      active                              as Active,
      status                              as Status,
      created_by                          as CreatedBy,
      created_at                          as CreatedAt,
      local_changed_by                    as LocalChangedBy,
      local_last_changed_at               as LocalLastChangedAt,
      last_changed_at                     as LastChangedAt,

      _createdUserDetails.UserDescription as CreatedUserDescription,
      _changedUserDetails.UserDescription as ChangedUserDescription
}
