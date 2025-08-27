@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JE Reversal Ret Interface - for auth obj'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define view entity /ZUORA001/I_REVRV2
  as select from /zuora001/t_revr
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
      res_system         as ResSystem
}
