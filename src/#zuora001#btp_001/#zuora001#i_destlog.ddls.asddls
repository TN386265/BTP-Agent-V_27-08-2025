@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Destination data log'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@AbapCatalog.extensibility: {
extensible: true,
elementSuffix: 'ZM0',
allowNewDatasources: false,
dataSources: [ '_dest' ],
quota:{
maximumFields: 250,
maximumBytes: 2500
}
}

define view entity /ZUORA001/I_DESTLOG
  as select from /ZUORA001/TF_DESTLOG as _dest
  association [1..1] to /ZUORA001/I_USERS as _createdUserDetails on _dest.CreatedBy = _createdUserDetails.UserID
  association [1..1] to /ZUORA001/I_USERS as _changedUserDetails on _dest.LocalChangedBy = _changedUserDetails.UserID
{
  key _dest.CustomerId,
  key _dest.Destinationid,
  key _dest.ValidFrom,
      _dest.ValidFrom_old,
      _dest.ValidTo,
      _dest.ValidTo_old,
      _dest.DestinationName,
      _dest.DestinationName_old,
      _dest.Description,
      _dest.Description_old,
      _dest.CapabilityId,
      _dest.CapabilityId_old,
      _dest.CapabilityName,
      _dest.CapabilityName_old,
      _dest.DestUsrl,
      _dest.DestUsrl_old,
      _dest.DestType,
      _dest.DestType_old,
      _dest.ProxyType,
      _dest.ProxyType_old,
      _dest.AuthType,
      _dest.AuthType_old,
      _dest.AuthUser,
      _dest.AuthUser_old,
      _dest.SystemId,
      _dest.SystemId_old,
      _dest.LandScape,
      _dest.LandScape_old,
      _dest.Status,
      _dest.Status_old,
      _dest.CreatedBy,
      _dest.CreatedAt,
      _dest.LocalChangedBy,
      _dest.LocalLastChangedAt,
      _dest.LastChangedAt,

      _createdUserDetails.UserDescription as CreatedUserDescription,
      _changedUserDetails.UserDescription as ChangedUserDescription
}
