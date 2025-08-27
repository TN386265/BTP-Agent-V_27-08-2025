@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value mapping JSON consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #M,
    dataClass: #MIXED
}

define root view entity /ZUORA001/C_MAPU
  provider contract transactional_query
  as projection on /ZUORA001/I_MAPU
{
  key CustomerId,
  key RuleId,
      SourceData,
      TargetData,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}
