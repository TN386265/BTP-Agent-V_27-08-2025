@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_JE_EXTH
  as select from /zuora001/t_exth
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
      field1             as Field1,
      field2             as Field2,
      field3             as Field3,
      field4             as Field4,
      DOCUMENTHEADER
}
