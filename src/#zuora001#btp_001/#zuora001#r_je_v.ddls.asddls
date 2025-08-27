@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal Entry - Vendor'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_JE_V as select from /zuora001/t_je_v
association to parent /ZUORA001/R_JE_H as DOCUMENTHEADER
    on $projection.je_uid = DOCUMENTHEADER.je_uid
    and $projection.customer_id =  DOCUMENTHEADER.customer_id
    and $projection.JeDocNumber =  DOCUMENTHEADER.JeDocNumber
{
    key je_uid as je_uid,
    key customer_id as customer_id,
    key je_doc_number as JeDocNumber,
    destination_system as DestinationSystem,
    destination_name as DestinationName,
    itemno_acc  as ItemnoAcc,
    vendor_no as VendorNo,
    gl_account as GlAccount,
    ref_key_1 as RefKey1,
    ref_key_2 as RefKey2,
    ref_key_3 as RefKey3,
    comp_code as CompCode,
    bus_area as BusArea,
    pmnttrms as Pmnttrms,
    bline_date as BlineDate,
    dsct_days1 as DsctDays1,
    dsct_days2 as DsctDays2,
    netterms as Netterms,
    dsct_pct1 as DsctPct1,
    dsct_pct2 as DsctPct2,
    pymt_meth as PymtMeth,
    pmtmthsupl as Pmtmthsupl,
    pmnt_block as PmntBlock,
    scbank_ind as ScbankInd,
    supcountry as Supcountry,
    supcountry_iso as SupcountryIso,
    bllsrv_ind as BllsrvInd,
    alloc_nmbr as AllocNmbr,
    item_text as ItemText,
    po_sub_no as PoSubNo,
    po_checkdg as PoCheckdg,
    po_ref_no as PoRefNo,
    pymt_cur_iso as PymtCurIso,
    sp_gl_ind as SpGlInd,
    tax_code as TaxCode,
    tax_date as TaxDate,
    taxjurcode as Taxjurcode,
    alt_payee as AltPayee,
    alt_payee_bank as AltPayeeBank,
    partner_bk as PartnerBk,
    bank_id as BankId,
    partner_guid as PartnerGuid,
    profit_ctr as ProfitCtr,
    fund as Fund,
    w_tax_code as WTaxCode,
    businessplace as Businessplace,
    sectioncode as Sectioncode,
    instr1 as Instr1,
    instr2 as Instr2,
    instr3 as Instr3,
    instr4 as Instr4,
    branch as Branch,
    pymt_cur as PymtCur,
    pymt_amt as PymtAmt,
    grant_nbr as GrantNbr,
    measure as Measure,
    housebankacctid as Housebankacctid,
    budget_period as BudgetPeriod,
    ppa_ex_ind as PpaExInd,
    part_businessplace as PartBusinessplace,
    housebank as Housebank,
    housebankaccount as Housebankaccount,
    DOCUMENTHEADER
}
