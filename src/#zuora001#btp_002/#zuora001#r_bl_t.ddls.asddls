@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Communication Structure Texts for Billing Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_BL_T
  as select from /zuora001/t_bl_t
  association to parent /ZUORA001/R_BL_H as CREATORDATAIN on  $projection.je_uid      = CREATORDATAIN.je_uid
                                                          and $projection.customer_id = CREATORDATAIN.customer_id
  //    and $projection.bl_doc_number =  CREATORDATAIN.bl_doc_number

{
  key je_uid             as je_uid,
  key customer_id        as customer_id,
      bl_doc_number      as bl_doc_number,
      destination_system as destination_system,
      destination_name   as destination_name,
      //    land_scape as Land_Scape,
      ref_doc            as REF_DOC,
      ref_item           as REF_ITEM,
      applobject         as APPLOBJECT,
      text_id            as TEXT_ID,
      langu              as LANGU,
      format_col         as FORMAT_COL,
      text_line          as TEXT_LINE,

      CREATORDATAIN

}
