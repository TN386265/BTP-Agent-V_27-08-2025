@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Notification Management'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/C_NOTF
  provider contract transactional_query
  as projection on /ZUORA001/I_NOTF as Notf
{
  key CustomerId,
  key NotificationId,
  key ValidFrom,
      ValidTo,
      EmailNotification,
      ReqFailure,
      ReqWarnings,
      ReqSuccess,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}
