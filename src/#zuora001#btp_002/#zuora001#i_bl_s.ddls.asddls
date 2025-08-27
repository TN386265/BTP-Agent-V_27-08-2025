@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO Info for Success ProcessBillDocItems'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_BL_S
  as select from /zuora001/t_bl_s
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
      ref_doc_item       as RefDocItem,
      bill_doc           as BillDoc,
      bill_doc_item      as BillDocItem,
      net_value          as NetValue,
      tax_value          as TaxValue,
      currency           as Currency,
      currency_iso       as CurrencyIso,
      net_value_item     as NetValueItem,
      tax_value_item     as TaxValueItem,
      gro_value_item     as GroValueItem,

      _CREATORDATAIN
}
