@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Interface for API Calls'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #TRANSACTIONAL
}
define view entity /ZUORA001/I_APICA
  as select from /zuora001/t_apic
{
  key je_uid                  as JeUid,
  key customer_id             as CustomerId,
  key je_doc_number           as JeDocNumber,
      capability_id           as CapabilityId,
      dsetination_system      as DsetinationSystem,
      destination_name        as DestinationName,
      api_start_date          as ApiStartDate,
      execution_time          as ExecutionTime,
      api_user_id             as ApiUserId,
      number_of_je_line_items as NumberOfJeLineItems,
      api_status              as ApiStatus,
      posting_type            as PostingType,
      land_scape              as LandScape,
      status                  as Status,
      created_by              as CreatedBy,
      created_at              as CreatedAt,
      local_changed_by        as LocalChangedBy,
      local_last_changed_at   as LocalLastChangedAt,
      last_changed_at         as LastChangedAt
}
