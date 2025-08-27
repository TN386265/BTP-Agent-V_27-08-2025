@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for Successfully Processed Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_BL_S
  as select from /zuora001/t_bl_s
       association to parent /ZUORA001/R_BL_H as CREATORDATAIN
  on $projection.je_uid = CREATORDATAIN.je_uid
    and $projection.customer_id =  CREATORDATAIN.customer_id
//    and $projection.bl_doc_number =  CREATORDATAIN.bl_doc_number

{
     key je_uid as je_uid,
    key customer_id as customer_id,
    bl_doc_number as bl_doc_number,
    destination_system as  destination_system,
    destination_name as destination_name ,
//    land_scape as Land_Scape,
      ref_doc            as ref_doc,
      ref_doc_item       as ref_doc_item,
      bill_doc           as bill_doc,
      bill_doc_item      as bill_doc_item,
      net_value          as net_value,
      tax_value          as tax_value,
      currency           as currency,
      currency_iso       as currency_iso,
      net_value_item     as net_value_item,
      tax_value_item     as tax_value_item,
      gro_value_item     as gro_value_item,
      CREATORDATAIN

}
