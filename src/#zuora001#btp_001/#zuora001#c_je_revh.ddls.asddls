@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View For Reverse JE'
@Metadata.ignorePropagatedAnnotations: true
define root view entity /ZUORA001/C_JE_REVH
  provider contract transactional_query
  as projection on /ZUORA001/R_JE_REVH
{
  key Je_Uid,
  key customer_id,
  key JeDocNumber,
      destination_system,
      destination_name,
      LandScape,
      ObjType,
      ObjKey,
      ObjSys,
      CompCode,
      Username,
      DocDate,
      pstngdate,
      ObjKeyR,
      RefDocNo,
      AcDocNo,
      ReasonRev,
      Vatdate,
      RETURN : redirected to composition child /ZUORA001/C_JE_REVR
}
