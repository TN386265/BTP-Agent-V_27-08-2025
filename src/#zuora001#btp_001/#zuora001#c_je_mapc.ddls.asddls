@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View For Mapping Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity /ZUORA001/C_JE_MAPC 
as projection on /ZUORA001/R_JE_MAPC 
{
    key CustomerId,
    key DestinationName,
    key CapabilityId,
    key RuleId,
    key ConditionSeq,
    key TargetSeq,
    Ruledescription,
    ObjType,
    SourceField,
    SourceValue,
    ValueType,
    RangeEndValue,
    TargetField,
    TargetValue,
    CreatedBy,
    CreatedAt,
    LocalChangedBy,
    LocalLastChangedAt,
    LastChangedAt
}
