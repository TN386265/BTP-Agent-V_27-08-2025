@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Customer Master'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/C_CUST
  provider contract transactional_query
  as projection on /ZUORA001/I_CUST as Cust
{
  key CustomerId,
  key ValidFrom,
      ValidTo,
      CustomerName,
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
