@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Return Parameter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_BL_RG
  as select from /zuora001/t_bl_r
  association to parent /ZUORA001/I_BL_HG as _CREATORDATAIN on  $projection.JeUid      = _CREATORDATAIN.JeUid
                                                            and $projection.CustomerId = _CREATORDATAIN.CustomerId
{
  key je_uid             as JeUid,
  key customer_id        as CustomerId,
  key bl_doc_number      as BlDocNumber,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
      land_scape         as LandScape,
      type               as Type,
      id                 as Id,
      number_n           as NumberN,
      message            as Message,
      log_no             as LogNo,
      log_msg_no         as LogMsgNo,
      message_v1         as MessageV1,
      message_v2         as MessageV2,
      message_v3         as MessageV3,

      _CREATORDATAIN
}
