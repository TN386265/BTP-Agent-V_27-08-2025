@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSOforComm.StruNFDcItmData'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/C_BL_NG
  as projection on /ZUORA001/I_BL_NG
{
  key JeUid,
  key CustomerId,
  key BlDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      DataIndex,
      DocNumber,
      ItmNumber,
      Compcode,
      Fiscyear,
      Nfmkey,
      Ratedetkey,
      Basekey,
      Exchangekey,
      Ratedetdat,
      Ratemonth,
      Actratedat,
      Rate,
      Ratecurky,
      Ratecurkyiso,
      Ratedoccur,
      Invoicebl,
      Bvaldoccur,
      Bvalcurkyd,
      Bvalcurkydiso,
      Netrate,
      Provider,
      Vendorcov,
      Coverageky,
      Postingdays,
      Updtype,
      /* Associations */
      _CREATORDATAIN : redirected to parent /ZUORA001/C_BL_HG
}
