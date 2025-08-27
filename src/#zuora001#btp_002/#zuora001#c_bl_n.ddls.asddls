@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '/ZUORA001/R_BL_N'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_BL_N as projection on /ZUORA001/R_BL_N
{
  key je_uid,
  key customer_id,
  bl_doc_number,
  destination_system,
  destination_name,   
    DATA_INDEX,
    DOC_NUMBER,
    ITM_NUMBER,
    COMPCODE,
    FISCYEAR,
    NFMKEY,
    RATEDETKEY,
    BASEKEY,
    EXCHANGEKEY,
    RATEDETDAT,
    RATEMONTH,
    ACTRATEDAT,
    RATE,
    RATECURKY,
    RATECURKYISO,
    RATEDOCCUR,
    INVOICEBL,
    BVALDOCCUR,
    BVALCURKYD,
    BVALCURKYDISO,
    NETRATE,
    PROVIDER,
    VENDORCOV,
    COVERAGEKY,
    POSTINGDAYS,
    UPDTYPE,
    CREATORDATAIN : redirected to parent /ZUORA001/C_BL_H
}
