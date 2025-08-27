@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for Successfully Processed Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_BL_S as projection on /ZUORA001/R_BL_S
{
   key je_uid,
   key customer_id,
bl_doc_number,
      destination_system,
      destination_name,   
    ref_doc,
    ref_doc_item,
    bill_doc,
    bill_doc_item,
    net_value,
    tax_value,
    currency,
    currency_iso,
    net_value_item,
    tax_value_item,
    gro_value_item,
    CREATORDATAIN: redirected to parent /ZUORA001/C_BL_H
}
