@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Communication Fields for Conditions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_BL_C as select from /zuora001/t_bl_c
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
    data_index     as DATA_INDEX,
    cond_type      as COND_TYPE,
    cond_value     as COND_VALUE,
    cond_curr      as COND_CURR,
    cond_p_unt     as COND_P_UNT,
    cond_d_unt     as COND_D_UNT,

    CREATORDATAIN

}
