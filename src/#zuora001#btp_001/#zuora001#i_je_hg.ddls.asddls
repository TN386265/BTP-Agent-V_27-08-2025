@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Header Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define root view entity /ZUORA001/I_JE_HG
  as select from /zuora001/t_je_h
  composition [0..*] of /ZUORA001/I_JE_IG as _item
  composition [0..*] of /ZUORA001/I_JE_CG as _currency
  composition [0..*] of /ZUORA001/I_JE_RG as _return

{
  key je_uid             as JeUid,
  key customer_id        as CustomerId,
  key je_doc_number      as JeDocNumber,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
      land_scape         as LandScape,
      obj_type           as ObjType,
      obj_key            as ObjKey,
      obj_sys            as ObjSys,
      bus_act            as BusAct,
      username           as Username,
      header_txt         as HeaderTxt,
      comp_code          as CompCode,
      doc_date           as DocDate,
      pstng_date         as PstngDate,
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
      exchange_rate      as ExchangeRate,
      lastchangedat      as Lastchangedat,
      locallastchangedat as Locallastchangedat,

      _item,

      _currency,

      _return
}
