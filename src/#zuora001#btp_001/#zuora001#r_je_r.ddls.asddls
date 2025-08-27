@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal Entry Return'
@Metadata.ignorePropagatedAnnotations: true
define view entity /ZUORA001/R_JE_R
  as select from /zuora001/t_je_r
  association to parent /ZUORA001/R_JE_H as documentheader on  $projection.Je_Uid      = documentheader.je_uid
                                                           and $projection.customer_id = documentheader.customer_id
                                                           and $projection.JeDocNumber = documentheader.JeDocNumber
{
  key je_uid             as Je_Uid,
  key je_doc_number      as JeDocNumber,
  key itemno_acc         as itemno_acc,
  key customer_id        as customer_id,
  key message            as Message,
      destination_system as destination_system,
      destination_name   as destination_name,
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
      documentheader
}
