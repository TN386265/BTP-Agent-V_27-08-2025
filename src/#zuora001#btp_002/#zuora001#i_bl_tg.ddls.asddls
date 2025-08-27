@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Comm Struct Txts for Bill Intrfc'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_BL_TG
  as select from /zuora001/t_bl_t
  association to parent /ZUORA001/I_BL_HG as _CREATORDATAIN on  $projection.JeUid      = _CREATORDATAIN.JeUid
                                                            and $projection.CustomerId = _CREATORDATAIN.CustomerId
{
  key je_uid             as JeUid,
  key customer_id        as CustomerId,
  key bl_doc_number      as BlDocNumber,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
      land_scape         as LandScape,
      ref_doc            as RefDoc,
      ref_item           as RefItem,
      applobject         as Applobject,
      text_id            as TextId,
      langu              as Langu,
      format_col         as FormatCol,
      text_line          as TextLine,

      _CREATORDATAIN
}
