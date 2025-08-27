@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ValMapv0 Read-only intrfc - for auth obj'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_MAPC0V2
  as select from /zuora001/t_mapc
  association [1..1] to /ZUORA001/I_USERS as _createdUserDetails on $projection.CreatedBy = _createdUserDetails.UserID
  association [1..1] to /ZUORA001/I_USERS as _changedUserDetails on $projection.LocalChangedBy = _changedUserDetails.UserID
{
  key customer_id                         as CustomerId,
  key destinationid                       as Destinationid,
  key destination_name                    as DestinationName,
  key capability_id                       as CapabilityId,
  key rule_id                             as RuleId,
  key condition_seq                       as ConditionSeq,
  key target_seq                          as TargetSeq,
  key valid_from                          as ValidFrom,
      valid_to                            as ValidTo,
      rule_description                    as RuleDescription,
      activated_date                      as ActivatedDate,
      expiry_date                         as ExpiryDate,
      source_field                        as SourceField,
      target_field                        as TargetField,
      source_value                        as SourceValue,
      target_value                        as TargetValue,
      mapping_type                        as MappingType,
      source_data                         as SourceData,
      target_data                         as TargetData,
      source_condition                    as SourceCondition,
      obj_type                            as ObjType,
      value_type                          as ValueType,
      range_end_value                     as RangeEndValue,
      status                              as Status,
      created_by                          as CreatedBy,
      created_at                          as CreatedAt,
      local_changed_by                    as LocalChangedBy,
      local_last_changed_at               as LocalLastChangedAt,
      last_changed_at                     as LastChangedAt,

      _createdUserDetails.UserDescription as CreatedUserDescription,
      _changedUserDetails.UserDescription as ChangedUserDescription
}
