@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Valid capability master records'

@AccessControl.authorizationCheck: #NOT_REQUIRED

define table function /ZUORA001/TF_CPBTV

returns
{
  client             : abap.clnt;
  CapabilityId       : /zuora001/decapbid;
  ValidFrom          : /zuora001/devalid_from;
  ValidTo            : /zuora001/devalid_to;
  CapabilityName     : /zuora001/decapb_name;
  Status             : /zuora001/destatus;
  CreatedBy          : abp_creation_user;
  CreatedAt          : abp_creation_tstmpl;
  LocalChangedBy     : abp_locinst_lastchange_user;
  LocalLastChangedAt : abp_locinst_lastchange_tstmpl;
  LastChangedAt      : abp_lastchange_tstmpl;
}
implemented by method
  /zuora001/cl_analytics_m=>get_valid_cpbt;