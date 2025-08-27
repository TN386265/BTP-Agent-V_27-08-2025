@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for Conditions to be Processed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_BL_T
  as projection on /ZUORA001/R_BL_T
{
  key je_uid,
  key customer_id,
      bl_doc_number,
      destination_system,
      destination_name,
      REF_DOC,
      REF_ITEM,
      APPLOBJECT,
      TEXT_ID,
      LANGU,
      FORMAT_COL,
      TEXT_LINE,

      CREATORDATAIN : redirected to parent /ZUORA001/C_BL_H
}
