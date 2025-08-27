@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Currency Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define view entity /ZUORA001/I_JE_CG
  as select from /zuora001/t_je_c
  association to parent /ZUORA001/I_JE_HG as _header on  $projection.CustomerId  = _header.CustomerId
                                                     and $projection.JeUid       = _header.JeUid
                                                     and $projection.JeDocNumber = _header.JeDocNumber
{
  key je_uid             as JeUid,
  key customer_id        as CustomerId,
  key je_doc_number      as JeDocNumber,
  key itemno_acc         as ItemnoAcc,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
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

      _header
}
