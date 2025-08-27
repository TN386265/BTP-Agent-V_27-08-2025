@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for APICall logs- for auth obj'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}


define view entity /ZUORA001/I_APICN
  as select from    /zuora001/t_apic                                              as a
    left outer join /zuora001/t_je_h                                              as h      on  h.je_uid        = a.je_uid
                                                                                            and h.customer_id   = a.customer_id
                                                                                            and h.je_doc_number = a.je_doc_number
    left outer join /zuora001/t_revh                                              as r      on  r.je_uid        = a.je_uid
                                                                                            and r.customer_id   = a.customer_id
                                                                                            and r.je_doc_number = a.je_doc_number
    inner join      /zuora001/t_cust                                              as c      on  c.customer_id = a.customer_id
                                                                                            and c.status      = '1'
    left outer join /zuora001/t_cpbt                                              as t      on  t.capability_id = a.capability_id
                                                                                            and t.status        = '1'
    left outer join /ZUORA001/DM_VALUES( p_dom_name: '/ZUORA001/DMAPI_POSTTYPE' ) as dom_pt on dom_pt.value_low = a.posting_type
{
  key a.je_uid                                                                   as JeUid,
  key a.customer_id                                                              as CustomerId,
  key a.je_doc_number                                                            as JeDocNumber,
      a.capability_id                                                            as CapabilityId,
      t.capability_name                                                          as CapabilityName,
      a.dsetination_system                                                       as DsetinationSystem,
      a.destination_name                                                         as DestinationName,
      a.api_start_date                                                           as ApiStartDate,
      a.execution_time                                                           as ExecutionTime,
      a.api_user_id                                                              as ApiUserId,
      a.number_of_je_line_items                                                  as NumberOfJeLineItems,
      a.api_status                                                               as ApiStatus,
      a.posting_type                                                             as PostingType,
      dom_pt.Descr                                                               as PostingTypeDescr,
      a.land_scape                                                               as LandScape,
      case when h.ref_doc_no is not null then h.ref_doc_no else r.ref_doc_no end as JournalRunNumber,
      a.status                                                                   as Status,
      a.created_by                                                               as CreatedBy,
      a.created_at                                                               as CreatedAt,
      a.local_changed_by                                                         as LocalChangedBy,
      a.local_last_changed_at                                                    as LocalLastChangedAt,
      a.last_changed_at                                                          as LastChangedAt
}
