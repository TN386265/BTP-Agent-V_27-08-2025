@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer capability data log'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_CPBCLOG
  as select from /ZUORA001/TF_CPBCLOG
  association [1..1] to /ZUORA001/I_USERS as _createdUserDetails on $projection.CreatedBy = _createdUserDetails.UserID
  association [1..1] to /ZUORA001/I_USERS as _changedUserDetails on $projection.LocalChangedBy = _changedUserDetails.UserID
{
  key CustomerId,
  key CapabilityId,
  key ValidFrom,
      ValidFrom_old,
      ValidTo,
      ValidTo_old,
      CapabilityName,
      ActivatedDate,
      ActivatedDate_old,
      ExpiryDate,
      ExpiryDate_old,
      Active,
      Active_old,
      Status,
      Status_old,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      _createdUserDetails.UserDescription as CreatedUserDescription,
      _changedUserDetails.UserDescription as ChangedUserDescription
}
