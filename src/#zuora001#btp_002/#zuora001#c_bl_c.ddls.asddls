@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for Conditions to be Processed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/C_BL_C as projection on /ZUORA001/R_BL_C
{
    key je_uid,
    key customer_id,
    bl_doc_number,
    destination_system,
    destination_name,   
    DATA_INDEX,
    COND_TYPE,
    COND_VALUE,
    COND_CURR,
    COND_P_UNT,
    COND_D_UNT,

    CREATORDATAIN : redirected to parent /ZUORA001/C_BL_H
}

