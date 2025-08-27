@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '/ZUORA001/R_BL_H'
@Metadata.ignorePropagatedAnnotations: true
define root view entity /ZUORA001/C_BL_H
  provider contract transactional_query
  as projection on /ZUORA001/R_BL_H
{
  key je_uid,
  key customer_id,
    bl_doc_number ,
      destination_system,
      destination_name,   
      land_scape,
      created_by,
      created_on,
      testrun,
      posting_type,
      Username,
      Lastchangedat,
      Locallastchangedat,
      BILLINGDATAIN   : redirected to composition child /ZUORA001/C_BL_I,
      CONDITIONDATAIN : redirected to composition child /ZUORA001/C_BL_C,
      CCARDDATAIN     : redirected to composition child /ZUORA001/C_BL_V,
      TEXTDATAIN      : redirected to composition child /ZUORA001/C_BL_T,
      ERRORS          : redirected to composition child /ZUORA001/C_BL_E,
      SUCCESS         : redirected to composition child /ZUORA001/C_BL_S,
      NFMETALLITMS    : redirected to composition child /ZUORA001/C_BL_N,
      RETURN          : redirected to composition child /ZUORA001/C_BL_R
}
