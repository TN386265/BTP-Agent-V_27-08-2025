@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO forCommTable:MeansOfPay Ord/Bill Doc'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_BL_VG
  as select from /zuora001/t_bl_v
  association to parent /ZUORA001/I_BL_HG as _CREATORDATAIN on  $projection.JeUid      = _CREATORDATAIN.JeUid
                                                            and $projection.CustomerId = _CREATORDATAIN.CustomerId
{
  key je_uid             as JeUid,
  key customer_id        as CustomerId,
  key bl_doc_number      as BlDocNumber,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
      land_scape         as LandScape,
      paytype            as Paytype,
      cc_type            as CcType,
      cc_number          as CcNumber,
      cc_seq_no          as CcSeqNo,
      cc_valid_f         as CcValidF,
      cc_valid_t         as CcValidT,
      cc_name            as CcName,
      authamount         as Authamount,
      currency           as Currency,
      currency_iso       as CurrencyIso,
      auth_flag          as AuthFlag,
      auth_date          as AuthDate,
      auth_time          as AuthTime,
      cc_auth_no         as CcAuthNo,
      auth_refno         as AuthRefno,
      merchidcl          as Merchidcl,
      terminal           as Terminal,
      dataorigin         as Dataorigin,
      cc_settled         as CcSettled,
      cc_loc_id          as CcLocId,
      bill_plan          as BillPlan,
      bill_plani         as BillPlani,
      bill_value         as BillValue,
      cc_token           as CcToken,
      ref_doc            as RefDoc,

      _CREATORDATAIN
}
