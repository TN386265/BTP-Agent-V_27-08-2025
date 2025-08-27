@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal Entry Currency Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/R_JE_C
  as select from /zuora001/t_je_c
  association to parent /ZUORA001/R_JE_H as documentheader on  $projection.Je_Uid      = documentheader.je_uid
                                                           and $projection.customer_id = documentheader.customer_id
                                                           and $projection.JeDocNumber = documentheader.JeDocNumber
{
  key je_uid             as Je_Uid,
  key customer_id        as customer_id,
  key je_doc_number      as JeDocNumber,
  key itemno_acc         as ItemnoAcc,
      destination_system as destination_system,
      destination_name   as destination_name,
      curr_type          as CurrType,
      currency           as Currency,
      currency_iso       as CurrencyIso,
      amt_doccur         as AmtDoccur,
      exch_rate          as ExchRate,
      exch_rate_v        as ExchRateV,
      amt_base           as AmtBase,
      disc_base          as DiscBase,
      disc_amt           as DiscAmt,
      tax_amt            as TaxAmt,
      documentheader
}
