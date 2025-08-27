@AbapCatalog.viewEnhancementCategory: [ #NONE ]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Billing Header Interface'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}


define root view entity /ZUORA001/I_BL_HG
  as select from /zuora001/t_bl_h
  composition [0..*] of /ZUORA001/I_BL_CG as _CONDITIONDATAIN
  composition [0..*] of /ZUORA001/I_BL_EG as _ERRORS
  composition [0..*] of /ZUORA001/I_BL_IG as _BILLINGDATAIN
  composition [0..*] of /ZUORA001/I_BL_NG as _NFMETALLITMS
  composition [0..*] of /ZUORA001/I_BL_RG as _RETURN
  composition [0..*] of /ZUORA001/I_BL_S  as _SUCCESS
  composition [0..*] of /ZUORA001/I_BL_TG as _TEXTDATAIN
  composition [0..*] of /ZUORA001/I_BL_VG as _CCARDDATAIN
{
  key je_uid             as JeUid,
  key customer_id        as CustomerId,
      bl_doc_number      as BlDocNumber,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
      land_scape         as LandScape,
      created_by         as CreatedBy,
      created_on         as CreatedOn,
      testrun            as Testrun,
      posting_type       as PostingType,
      lastchangedat      as Lastchangedat,
      locallastchangedat as Locallastchangedat,
      username           as Username,

      _CONDITIONDATAIN,

      _ERRORS,

      _BILLINGDATAIN,

      _NFMETALLITMS,

      _RETURN,

      _SUCCESS,

      _TEXTDATAIN,

      _CCARDDATAIN
}
