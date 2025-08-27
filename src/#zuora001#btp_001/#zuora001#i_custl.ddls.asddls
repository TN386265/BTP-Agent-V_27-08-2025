@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer ReadOnly interface - Cpb filter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


define view entity /ZUORA001/I_CUSTL
  with parameters
    p_capability_id : /zuora001/delongchar
  as select from /ZUORA001/TF_CSTLIST(p_capability_id:$parameters.p_capability_id)
  association [1..1] to /ZUORA001/I_USERS as _createdUserDetails on $projection.CreatedBy = _createdUserDetails.UserID
  association [1..1] to /ZUORA001/I_USERS as _changedUserDetails on $projection.LocalChangedBy = _changedUserDetails.UserID
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

      _createdUserDetails.UserDescription as CreatedUserDescription,
      _changedUserDetails.UserDescription as ChangedUserDescription
}
