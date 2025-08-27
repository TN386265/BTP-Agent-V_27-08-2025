@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for capab mas-valid records'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_CPBTAV
  as select from /ZUORA001/TF_CPBTV
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
