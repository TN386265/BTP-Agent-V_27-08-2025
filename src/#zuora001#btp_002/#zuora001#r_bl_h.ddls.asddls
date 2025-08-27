@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View For Billing Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity /ZUORA001/R_BL_H as select from /zuora001/t_bl_h
 composition [0..*] of /ZUORA001/R_BL_I as BILLINGDATAIN
 composition [0..*] of /ZUORA001/R_BL_C as CONDITIONDATAIN
 composition [0..*] of /ZUORA001/R_BL_V as CCARDDATAIN
 composition [0..*] of /ZUORA001/R_BL_T as TEXTDATAIN
 composition [0..*] of /ZUORA001/R_BL_E as ERRORS
 composition [0..*] of /ZUORA001/R_BL_N as NFMETALLITMS
 composition [0..*] of /ZUORA001/R_BL_R as RETURN 
 composition [0..*] of /ZUORA001/R_BL_S as SUCCESS
{
    key je_uid as je_uid,
    key customer_id as customer_id,
    bl_doc_number as bl_doc_number,
    destination_system as  destination_system,
    destination_name as destination_name ,
    land_scape as land_scape,
    created_by as created_by,
    created_on as created_on,
    testrun as testrun,
    username as Username,
    posting_type as posting_type,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat,
    BILLINGDATAIN,
    CONDITIONDATAIN,
    CCARDDATAIN,
    TEXTDATAIN,
    ERRORS,
    SUCCESS,
    NFMETALLITMS,
    RETURN
}
