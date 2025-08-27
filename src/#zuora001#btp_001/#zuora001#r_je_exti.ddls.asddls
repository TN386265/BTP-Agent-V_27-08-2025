@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_JE_EXTI
  as select from /zuora001/t_exti
  association to parent /ZUORA001/R_JE_H as DOCUMENTHEADER
    on $projection.je_uid = DOCUMENTHEADER.je_uid
    and $projection.customer_id =  DOCUMENTHEADER.customer_id
    and $projection.JeDocNumber =  DOCUMENTHEADER.JeDocNumber
{
  key je_uid             as je_uid,
  key customer_id        as customer_id,
  key je_doc_number      as JeDocNumber,
  key itemno_acc         as ItemnoAcc,
      destination_system as destination_system,
      destination_name   as destination_name,
      structure          as Structure,
      valuepart1         as Valuepart1,
      valuepart2         as Valuepart2,
      valuepart3         as Valuepart3,
      valuepart4         as Valuepart4,
      DOCUMENTHEADER
}
