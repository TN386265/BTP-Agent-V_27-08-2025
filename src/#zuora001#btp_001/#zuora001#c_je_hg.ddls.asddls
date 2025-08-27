@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for Header Interface'
@Metadata.ignorePropagatedAnnotations: true

define root view entity /ZUORA001/C_JE_HG
  provider contract transactional_query
  as projection on /ZUORA001/I_JE_HG
{
  key JeUid,
  key CustomerId,
  key JeDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      ObjType,
      ObjKey,
      ObjSys,
      BusAct,
      Username,
      HeaderTxt,
      CompCode,
      DocDate,
      PstngDate,
      TransDate,
      FiscYear,
      FisPeriod,
      DocType,
      RefDocNo,
      AcDocNo,
      ObjKeyR,
      ReasonRev,
      CompoAcc,
      RefDocNoLong,
      AccPrinciple,
      NegPostng,
      ObjKeyInv,
      BillCategory,
      Vatdate,
      InvoiceRecDate,
      EcsEnv,
      PartialRev,
      DocStatus,
      ExchangeRate,
      Lastchangedat,
      Locallastchangedat,
      /* Associations */
      _item     : redirected to composition child /ZUORA001/C_JE_IG,

      _currency : redirected to composition child /ZUORA001/C_JE_CG,

      _return   : redirected to composition child /ZUORA001/C_JE_RG
}
