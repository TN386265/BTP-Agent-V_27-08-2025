@EndUserText.label: 'Invoice Header for Interface'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity /ZUORA001/R_JE_H
  as select from /zuora001/t_je_h
  composition [0..*] of /ZUORA001/R_JE_I as ACCOUNTGL
  composition [0..*] of /ZUORA001/R_JE_C as CURRENCYAMOUNT
  composition [0..*] of /ZUORA001/R_JE_Z as ACCOUNTRECEIVABLE
  composition [0..*] of /ZUORA001/R_JE_V as ACCOUNTPAYABLE
  composition [0..*] of /ZUORA001/R_JE_R as RETURN
  composition [0..*] of /ZUORA001/R_JE_EXTH as EXTENSION1
  composition [0..*] of /ZUORA001/R_JE_EXTI as EXTENSION2
  composition [0..*] of /ZUORA001/R_JE_T as ACCOUNTTAX
{
  key je_uid             as je_uid,
  key customer_id        as customer_id,
  key je_doc_number      as JeDocNumber,
      destination_system as destination_system,
      destination_name   as destination_name,
      land_scape as LandScape,
      obj_type           as ObjType,
      obj_key            as ObjKey,
      obj_sys            as ObjSys,
      bus_act            as BusAct,
      username           as Username,
      header_txt         as HeaderTxt,
      comp_code          as CompCode,
      doc_date           as DocDate,
      pstng_date         as pstngdate,
      trans_date         as TransDate,
      fisc_year          as FiscYear,
      fis_period         as FisPeriod,
      doc_type           as DocType,
      ref_doc_no         as RefDocNo,
      ac_doc_no          as AcDocNo,
      obj_key_r          as ObjKeyR,
      reason_rev         as ReasonRev,
      compo_acc          as CompoAcc,
      ref_doc_no_long    as RefDocNoLong,
      acc_principle      as AccPrinciple,
      neg_postng         as NegPostng,
      obj_key_inv        as ObjKeyInv,
      bill_category      as BillCategory,
      vatdate            as Vatdate,
      invoice_rec_date   as InvoiceRecDate,
      ecs_env            as EcsEnv,
      partial_rev        as PartialRev,
      doc_status         as DocStatus,
      exchange_rate  as ExchangRate,
      ACCOUNTGL,
      CURRENCYAMOUNT,
      ACCOUNTRECEIVABLE,
      ACCOUNTPAYABLE,
      RETURN,      
      EXTENSION1,
      EXTENSION2,
      ACCOUNTTAX
}
