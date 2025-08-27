@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection on GSOforComm-Fields for Cond'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/C_BL_CG
  as projection on /ZUORA001/I_BL_CG
{
  key JeUid,
  key CustomerId,
  key BlDocNumber,
      DestinationSystem,
      DestinationName,
      LandScape,
      DataIndex,
      CondType,
      CondValue,
      CondCurr,
      CondPUnt,
      CondDUnt,
      /* Associations */
      _CREATORDATAIN : redirected to parent /ZUORA001/C_BL_HG
}
