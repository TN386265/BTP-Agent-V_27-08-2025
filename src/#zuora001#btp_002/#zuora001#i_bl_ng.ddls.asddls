@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Comm. Struct NF Doc Item Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_BL_NG
  as select from /zuora001/t_bl_n
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
      doc_number         as DocNumber,
      itm_number         as ItmNumber,
      compcode           as Compcode,
      fiscyear           as Fiscyear,
      nfmkey             as Nfmkey,
      ratedetkey         as Ratedetkey,
      basekey            as Basekey,
      exchangekey        as Exchangekey,
      ratedetdat         as Ratedetdat,
      ratemonth          as Ratemonth,
      actratedat         as Actratedat,
      rate               as Rate,
      ratecurky          as Ratecurky,
      ratecurkyiso       as Ratecurkyiso,
      ratedoccur         as Ratedoccur,
      invoicebl          as Invoicebl,
      bvaldoccur         as Bvaldoccur,
      bvalcurkyd         as Bvalcurkyd,
      bvalcurkydiso      as Bvalcurkydiso,
      netrate            as Netrate,
      provider           as Provider,
      vendorcov          as Vendorcov,
      coverageky         as Coverageky,
      postingdays        as Postingdays,
      updtype            as Updtype,

      _CREATORDATAIN
}
