@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AccountTax'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_JE_T 
as select from /zuora001/t_je_t
association to parent /ZUORA001/R_JE_H as DOCUMENTHEADER
    on $projection.je_uid = DOCUMENTHEADER.je_uid
    and $projection.customer_id =  DOCUMENTHEADER.customer_id
    and $projection.JeDocNumber =  DOCUMENTHEADER.JeDocNumber
{
    key je_uid as je_uid,
    key customer_id as customer_id,
    key je_doc_number as JeDocNumber,
    key itemno_acc as ItemnoAcc,
    destination_system as destination_system,
    destination_name as destination_name ,
    gl_account as GlAccount,
    cond_key as CondKey,
    acct_key as AcctKey,
    tax_code as TaxCode,
    tax_rate as TaxRate,
    tax_date as TaxDate,
    taxjurcode as Taxjurcode,
    taxjurcode_deep as TaxjurcodeDeep,
    taxjurcode_level as TaxjurcodeLevel,
    itemno_tax as ItemnoTax,
    direct_tax as DirectTax,
    DOCUMENTHEADER
}
