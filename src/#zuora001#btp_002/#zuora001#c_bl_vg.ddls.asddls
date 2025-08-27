@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSOCmTb:MnsOfPayOrd/BilDoc'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/C_BL_VG
  as projection on /ZUORA001/I_BL_VG
{
  key JeUid,
  key CustomerId,
  key BlDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      Paytype,
      CcType,
      CcNumber,
      CcSeqNo,
      CcValidF,
      CcValidT,
      CcName,
      Authamount,
      Currency,
      CurrencyIso,
      AuthFlag,
      AuthDate,
      AuthTime,
      CcAuthNo,
      AuthRefno,
      Merchidcl,
      Terminal,
      Dataorigin,
      CcSettled,
      CcLocId,
      BillPlan,
      BillPlani,
      BillValue,
      CcToken,
      RefDoc,
      /* Associations */
      _CREATORDATAIN : redirected to parent /ZUORA001/C_BL_HG
}
