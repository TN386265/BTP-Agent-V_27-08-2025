@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JE Reversal Interface - for auth obj'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define view entity /ZUORA001/I_REVHV2
  as select from /zuora001/t_revh
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
      comp_code          as CompCode,
      username           as Username,
      doc_date           as DocDate,
      pstng_date         as PstngDate,
      obj_key_r          as ObjKeyR,
      ref_doc_no         as RefDocNo,
      ac_doc_no          as AcDocNo,
      reason_rev         as ReasonRev,
      vatdate            as Vatdate,
      lastchangedat      as Lastchangedat,
      locallastchangedat as Locallastchangedat
}
