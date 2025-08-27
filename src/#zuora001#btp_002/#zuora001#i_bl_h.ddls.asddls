@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Interface for Billing Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define view entity /ZUORA001/I_BL_H 
as select from /zuora001/t_bl_h
{
    key je_uid as je_uid,
    key customer_id as customer_id,
    key bl_doc_number as bl_doc_number,
    destination_system as  destination_system,
    destination_name as destination_name ,
    land_scape as Land_Scape,
    created_by as created_by,
    created_on as created_on,
    testrun as testrun,
    posting_type as posting_type,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat
}
