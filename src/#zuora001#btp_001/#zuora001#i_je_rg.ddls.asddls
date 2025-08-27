@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSO for Return Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_JE_RG
  as select from /zuora001/t_je_r
  association to parent /ZUORA001/I_JE_HG as _header on  $projection.CustomerId  = _header.CustomerId
                                                     and $projection.JeUid       = _header.JeUid
                                                     and $projection.JeDocNumber = _header.JeDocNumber
{
  key je_uid             as JeUid,
  key je_doc_number      as JeDocNumber,
  key itemno_acc         as ItemnoAcc,
  key customer_id        as CustomerId,
  key message            as Message,
      destination_system as DestinationSystem,
      destination_name   as DestinationName,
      type               as Type,
      res_id             as ResId,
      res_number         as ResNumber,
      log_no             as LogNo,
      log_msg_no         as LogMsgNo,
      message_v1         as MessageV1,
      message_v2         as MessageV2,
      message_v3         as MessageV3,
      message_v4         as MessageV4,
      res_parameter      as ResParameter,
      res_row            as ResRow,
      field              as Field,
      res_system         as ResSystem,

      _header
}
