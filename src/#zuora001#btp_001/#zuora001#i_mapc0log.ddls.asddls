@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value mapping data log'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


@AbapCatalog.extensibility: {
extensible: true,
elementSuffix: 'ZM0',
allowNewDatasources: false,
dataSources: [ 'mapc' ],
quota:{
maximumFields: 250,
maximumBytes: 2500
}
}

define view entity /ZUORA001/I_MAPC0LOG
  as select from /ZUORA001/TF_MAPC0LOG as mapc
  association [1..1] to /ZUORA001/I_USERS as _createdUserDetails on mapc.CreatedBy = _createdUserDetails.UserID
  association [1..1] to /ZUORA001/I_USERS as _changedUserDetails on mapc.LocalChangedBy = _changedUserDetails.UserID
{
  key CustomerId,
  key Destinationid,
  key DestinationName,
  key CapabilityId,
  key RuleId,
  key ConditionSeq,
  key TargetSeq,
  key ValidFrom,
      ValidFrom_old,
      CapabilityName,
      ValidTo,
      ValidTo_old,
      RuleDescription,
      RuleDescription_old,
      ActivatedDate,
      ActivatedDate_old,
      ExpiryDate,
      ExpiryDate_old,
      SourceField,
      SourceField_old,
      TargetField,
      TargetField_old,
      SourceValue,
      SourceValue_old,
      TargetValue,
      TargetValue_old,
      MappingType,
      MappingType_old,
      SourceData,
      SourceData_old,
      TargetData,
      TargetData_old,
      SourceCondition,
      SourceCondition_old,
      ObjType,
      ObjType_old,
      ValueType,
      ValueType_old,
      RangeEndValue,
      RangeEndValue_old,
      Status,
      Status_old,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      _createdUserDetails.UserDescription as CreatedUserDescription,
      _changedUserDetails.UserDescription as ChangedUserDescription
}
