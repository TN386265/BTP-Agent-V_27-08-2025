@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Communications-Fields for Cond.'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_BL_CG
  as select from /zuora001/t_bl_c
  association to parent /ZUORA001/I_BL_HG as _CREATORDATAIN on  $projection.JeUid      = _CREATORDATAIN.JeUid
                                                            and $projection.CustomerId = _CREATORDATAIN.CustomerId
{
  key je_uid             as JeUid,
  key customer_id        as CustomerId,
  key bl_doc_number      as BlDocNumber,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
      land_scape         as LandScape,
      data_index         as DataIndex,
      cond_type          as CondType,
      cond_value         as CondValue,
      cond_curr          as CondCurr,
      cond_p_unt         as CondPUnt,
      cond_d_unt         as CondDUnt,

      _CREATORDATAIN
}
