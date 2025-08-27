@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View for Reverse Journal'
@Metadata.ignorePropagatedAnnotations: true
define root view entity /ZUORA001/R_JE_REVH 
as select from /zuora001/t_revh
 composition [0..*] of /ZUORA001/R_JE_REVR as RETURN
{
    key je_uid as Je_Uid,
    key customer_id as customer_id,
    key je_doc_number as JeDocNumber,
    destination_system as destination_system,
    destination_name as destination_name,
    land_scape  as LandScape,
    obj_type as ObjType,
    obj_key as ObjKey,
    obj_sys as ObjSys,
    comp_code as CompCode,
    username as Username,
    doc_date as DocDate,
    pstng_date as pstngdate,
    obj_key_r as ObjKeyR,
    ref_doc_no as RefDocNo,
    ac_doc_no as AcDocNo,
    reason_rev as ReasonRev,
    vatdate as Vatdate ,
    RETURN
}
