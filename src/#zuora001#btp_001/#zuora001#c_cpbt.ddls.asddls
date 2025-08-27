@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Capability Master'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/C_CPBT
  provider contract transactional_query
  as projection on /ZUORA001/I_CPBT as CapbMas
{
  key CapabilityId,
  key ValidFrom,
      ValidTo,
      CapabilityName,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}
