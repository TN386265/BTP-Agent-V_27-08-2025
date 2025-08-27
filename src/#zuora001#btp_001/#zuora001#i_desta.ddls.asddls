@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for destination - view entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@AbapCatalog.extensibility: {
extensible: true,
elementSuffix: 'Zds',
allowNewDatasources: false,
dataSources: [ '_dest' ],
quota:{
maximumFields: 250,
maximumBytes: 2500
}
}

define view entity /ZUORA001/I_DESTA
  as select from /zuora001/t_dest as _dest
{
  key customer_id           as CustomerId,
  key destinationid         as Destinationid,
  key valid_from            as ValidFrom,
      valid_to              as ValidTo,
      destination_name      as DestinationName,
      description           as Description,
      capability_id         as CapabilityId,
      dest_usrl             as DestUsrl,
      dest_type             as DestType,
      proxy_type            as ProxyType,
      auth_type             as AuthType,
      auth_user             as AuthUser,
      auth_pwd              as AuthPwd,
      system_id             as SystemId,
      land_scape            as LandScape,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
