@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Customer Capability Link'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #M,
    dataClass: #MIXED
}
define root view entity /ZUORA001/C_CPBC
  provider contract transactional_query
  as projection on /ZUORA001/I_CPBC
{
  key CapabilityId,
  key CustomerId,
  key ValidFrom,
      ValidTo,
      ActivatedDate,
      ExpiryDate,
      Active,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      CreatedUserDescription,
      ChangedUserDescription
}
