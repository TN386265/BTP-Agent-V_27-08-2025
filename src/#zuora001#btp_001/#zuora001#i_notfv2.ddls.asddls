@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Notif Read only interface - for auth obj'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_NOTFV2
  as select from /zuora001/t_notf
{
  key customer_id           as CustomerId,
  key notification_id       as NotificationId,
  key valid_from            as ValidFrom,
      valid_to              as ValidTo,
      email_notification    as EmailNotification,
      req_failure           as ReqFailure,
      req_warnings          as ReqWarnings,
      req_success           as ReqSuccess,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
