@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Destination Master'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/C_DEST
  provider contract transactional_query
  as projection on /ZUORA001/I_DEST
{
  key CustomerId,
  key Destinationid,
  key ValidFrom,
      ValidTo,
      DestinationName,
      Description,
      CapabilityId,
      DestUsrl,
      DestType,
      ProxyType,
      AuthType,
      AuthUser,
      AuthPwd,
      SystemId,
      LandScape,
      Status,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      CreatedUserDescription,
      ChangedUserDescription
}
