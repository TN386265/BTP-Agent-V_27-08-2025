//@AbapCatalog.sqlViewName: '/ZUORA001/VIDEST'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true

@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for Destination master data'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/I_DEST
  as select from /zuora001/t_dest
  association [1..1] to /ZUORA001/I_USERS as _createdUserDetails on $projection.CreatedBy = _createdUserDetails.UserID
  association [1..1] to /ZUORA001/I_USERS as _changedUserDetails on $projection.LocalChangedBy = _changedUserDetails.UserID
{
  key customer_id                         as CustomerId,
  key destinationid                       as Destinationid,
  key valid_from                          as ValidFrom,
      valid_to                            as ValidTo,
      destination_name                    as DestinationName,
      description                         as Description,
      capability_id                       as CapabilityId,
      dest_usrl                           as DestUsrl,
      dest_type                           as DestType,
      proxy_type                          as ProxyType,
      auth_type                           as AuthType,
      auth_user                           as AuthUser,
      auth_pwd                            as AuthPwd,
      system_id                           as SystemId,
      land_scape                          as LandScape,
      status                              as Status,
      created_by                          as CreatedBy,
      created_at                          as CreatedAt,
      local_changed_by                    as LocalChangedBy,
      local_last_changed_at               as LocalLastChangedAt,
      last_changed_at                     as LastChangedAt,

      _createdUserDetails.UserDescription as CreatedUserDescription,
      _changedUserDetails.UserDescription as ChangedUserDescription
}
