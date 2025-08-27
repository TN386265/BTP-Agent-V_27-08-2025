@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal Entry - Customer'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/R_JE_Z
  as select from /zuora001/t_je_z
  association to parent /ZUORA001/R_JE_H as DOCUMENTHEADER 
  on  $projection.je_uid      = DOCUMENTHEADER.je_uid
  and $projection.customer_id = DOCUMENTHEADER.customer_id
  and $projection.JeDocNumber = DOCUMENTHEADER.JeDocNumber
{
  key je_uid             as je_uid,
  key customer_id        as customer_id,
  key je_doc_number      as JeDocNumber,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
      itemno_acc         as ItemnoAcc,
      customer           as Customer,
      gl_account         as GlAccount,
      ref_key_1          as RefKey1,
      ref_key_2          as RefKey2,
      ref_key_3          as RefKey3,
      comp_code          as CompCode,
      bus_area           as BusArea,
      tax_code as TaxCode,
      pmnttrms           as Pmnttrms,
      bline_date         as BlineDate,
      dsct_days1         as DsctDays1,
      dsct_days2         as DsctDays2,
      netterms           as Netterms,
      dsct_pct1          as DsctPct1,
      dsct_pct2          as DsctPct2,
      pymt_meth          as PymtMeth,
      pmtmthsupl         as Pmtmthsupl,
      paymt_ref          as PaymtRef,
      dunn_key           as DunnKey,
      dunn_block         as DunnBlock,
      pmnt_block         as PmntBlock,
      vat_reg_no         as VatRegNo,
      alloc_nmbr         as AllocNmbr,
      item_text          as ItemText,
      partner_bk         as PartnerBk,
      housebank          as Housebank,
      housebankaccount   as Housebankaccount,
      DOCUMENTHEADER
}
