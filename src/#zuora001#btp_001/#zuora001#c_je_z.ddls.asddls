@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal Entry - Customer projection'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_JE_Z 
as projection on /ZUORA001/R_JE_Z
{
    key je_uid,
    key customer_id,
    key JeDocNumber,
    DestinationSystem,
    DestinationName,
    ItemnoAcc,
    Customer,
    GlAccount,
    RefKey1,
    RefKey2,
    RefKey3,
    CompCode,
    TaxCode,
    BusArea,
    Pmnttrms,
    BlineDate,
    DsctDays1,
    DsctDays2,
    Netterms,
    DsctPct1,
    DsctPct2,
    PymtMeth,
    Pmtmthsupl,
    PaymtRef,
    DunnKey,
    DunnBlock,
    PmntBlock,
    VatRegNo,
    AllocNmbr,
    ItemText,
    PartnerBk,
    Housebank,
    Housebankaccount,
   DOCUMENTHEADER : redirected to parent /ZUORA001/C_JE_H
}
    
