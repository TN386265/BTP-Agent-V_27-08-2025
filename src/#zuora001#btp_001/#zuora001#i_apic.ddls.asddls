@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for API Call logs'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define view entity /ZUORA001/I_APIC
  with parameters
    p_custid : /zuora001/decustomerid
  as select from /zuora001/t_apic
{
  key je_uid                  as JeUid,
  key customer_id             as CustomerId,
  key je_doc_number           as JeDocNumber,
      dsetination_system      as DsetinationSystem,
      destination_name        as DestinationName,
      api_start_date          as ApiStartDate,
      execution_time          as ExecutionTime,
      api_user_id             as ApiUserId,
      number_of_je_line_items as NumberOfJeLineItems,
      api_status              as ApiStatus,
      status                  as Status,
      created_by              as CreatedBy,
      created_at              as CreatedAt,
      local_changed_by        as LocalChangedBy,
      local_last_changed_at   as LocalLastChangedAt,
      last_changed_at         as LastChangedAt
}
where
  customer_id = $parameters.p_custid
