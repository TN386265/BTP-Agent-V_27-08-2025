@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Value mapping data log'

@AccessControl.authorizationCheck: #NOT_REQUIRED

define table function /ZUORA001/TF_MAPC0LOG
returns
{
  client              : abap.clnt;
  CustomerId          : /zuora001/decustomerid;
  Destinationid       : /zuora001/dedestid;
  DestinationName     : /zuora001/dedest_name;
  CapabilityId        : /zuora001/decapbid;
  CapabilityName      : /zuora001/decapb_name;
  RuleId              : /zuora001/de_rule_id;
  ConditionSeq        : /zuora001/decondid;
  TargetSeq           : /zuora001/detargseq;
  ValidFrom           : /zuora001/devalid_from;
  ValidFrom_old       : /zuora001/devalid_from;
  ValidTo             : /zuora001/devalid_to;
  ValidTo_old         : /zuora001/devalid_to;
  RuleDescription     : /zuora001/deruledescr;
  RuleDescription_old : /zuora001/deruledescr;
  ActivatedDate       : /zuora001/deactivated_date;
  ActivatedDate_old   : /zuora001/deactivated_date;
  ExpiryDate          : /zuora001/deexpiry_date;
  ExpiryDate_old      : /zuora001/deexpiry_date;
  SourceField         : /zuora001/desrcfld;
  SourceField_old     : /zuora001/desrcfld;
  TargetField         : /zuora001/detgtfld;
  TargetField_old     : /zuora001/detgtfld;
  SourceValue         : abap.char(50);
  SourceValue_old     : abap.char(50);
  TargetValue         : abap.char(50);
  TargetValue_old     : abap.char(50);
  MappingType         : /zuora001/devmaptype;
  MappingType_old     : /zuora001/devmaptype;
  SourceData          : /zuora001/devmsrcdata;
  SourceData_old      : /zuora001/devmsrcdata;
  TargetData          : /zuora001/devmtgtdata;
  TargetData_old      : /zuora001/devmtgtdata;
  SourceCondition     : /zuora001/desrccond;
  SourceCondition_old : /zuora001/desrccond;
  ObjType             : abap.char(1);
  ObjType_old         : abap.char(1);
  ValueType           : abap.char(1);
  ValueType_old       : abap.char(1);
  RangeEndValue       : abap.char(50);
  RangeEndValue_old   : abap.char(50);
  Status              : /zuora001/destatus;
  Status_old          : /zuora001/destatus;
  CreatedBy           : abp_creation_user;
  CreatedAt           : abp_creation_tstmpl;
  LocalChangedBy      : abp_locinst_lastchange_user;
  LocalLastChangedAt  : abp_locinst_lastchange_tstmpl;
  LastChangedAt       : abp_lastchange_tstmpl;
}
implemented by method
  /zuora001/cl_data_log=>mpac0;