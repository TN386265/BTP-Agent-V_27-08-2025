@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSO for BillHead Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity /ZUORA001/C_BL_HG
  provider contract transactional_query
  as projection on /ZUORA001/I_BL_HG
{
  key JeUid,
  key CustomerId,
      BlDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      CreatedBy,
      CreatedOn,
      Testrun,
      PostingType,
      Lastchangedat,
      Locallastchangedat,
      Username,

      /* Associations */
      _BILLINGDATAIN   : redirected to composition child /ZUORA001/C_BL_IG,
      _CCARDDATAIN     : redirected to composition child /ZUORA001/C_BL_VG,
      _CONDITIONDATAIN : redirected to composition child /ZUORA001/C_BL_CG,
      _ERRORS          : redirected to composition child /ZUORA001/C_BL_EG,
      _NFMETALLITMS    : redirected to composition child /ZUORA001/C_BL_NG,
      _RETURN          : redirected to composition child /ZUORA001/C_BL_RG,
      _SUCCESS         : redirected to composition child /ZUORA001/C_BL_SG,
      _TEXTDATAIN      : redirected to composition child /ZUORA001/C_BL_TG
}
