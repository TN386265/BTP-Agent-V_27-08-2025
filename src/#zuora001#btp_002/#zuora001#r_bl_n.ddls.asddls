@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '/ZUORA001/T_BL_N'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_BL_N
  as select from /zuora001/t_bl_n
        association to parent /ZUORA001/R_BL_H as CREATORDATAIN
  on $projection.je_uid = CREATORDATAIN.je_uid
    and $projection.customer_id =  CREATORDATAIN.customer_id
//    and $projection.bl_doc_number =  CREATORDATAIN.bl_doc_number

{
    key je_uid as je_uid,
    key customer_id as customer_id,
    bl_doc_number as bl_doc_number,
    destination_system as  destination_system,
    destination_name as destination_name ,
//    land_scape as Land_Scape,
      data_index         as DATA_INDEX,
      doc_number         as DOC_NUMBER,
      itm_number         as ITM_NUMBER,
      compcode           as COMPCODE,
      fiscyear           as FISCYEAR,
      nfmkey             as NFMKEY,
      ratedetkey         as RATEDETKEY,
      basekey            as BASEKEY,
      exchangekey        as EXCHANGEKEY,
      ratedetdat         as RATEDETDAT,
      ratemonth          as RATEMONTH,
      actratedat         as ACTRATEDAT,
      rate               as RATE,
      ratecurky          as RATECURKY,
      ratecurkyiso       as RATECURKYISO,
      ratedoccur         as RATEDOCCUR,
      invoicebl          as INVOICEBL,
      bvaldoccur         as BVALDOCCUR,
      bvalcurkyd         as BVALCURKYD,
      bvalcurkydiso      as BVALCURKYDISO,
      netrate            as NETRATE,
      provider           as PROVIDER,
      vendorcov          as VENDORCOV,
      coverageky         as COVERAGEKY,
      postingdays        as POSTINGDAYS,
      updtype            as UPDTYPE,
      CREATORDATAIN

}
