@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View for Journal'
@Metadata.ignorePropagatedAnnotations: true
define root view entity /ZUORA001/C_JE_H
  provider contract transactional_query
  as projection on /ZUORA001/R_JE_H
{
  key je_uid,
  key customer_id,
  key JeDocNumber,
      destination_system,
      destination_name,
      LandScape,
      ObjType,
      ObjKey,
      ObjSys,
      BusAct,
      Username,
      HeaderTxt,
      CompCode,
      DocDate,
      pstngdate,
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
      ExchangRate,
      /* Associations */
      ACCOUNTGL      : redirected to composition child /ZUORA001/C_JE_I,
      /* Associations */
      CURRENCYAMOUNT : redirected to composition child /ZUORA001/C_JE_C,
      
      ACCOUNTRECEIVABLE : redirected to composition child /ZUORA001/C_JE_Z,
      
      ACCOUNTPAYABLE : redirected to composition child /ZUORA001/C_JE_V,
      /* Associations */
      RETURN         : redirected to composition child /ZUORA001/C_JE_R,
      /* Associations */
      EXTENSION1     : redirected to composition child /ZUORA001/C_JE_EXTH,
      /* Associations */
      EXTENSION2     : redirected to composition child /ZUORA001/C_JE_EXTI,
      
      ACCOUNTTAX     : redirected to composition child /ZUORA001/C_JE_T
      
}
