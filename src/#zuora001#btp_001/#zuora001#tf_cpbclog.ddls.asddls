@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Customer capability data log'

@AccessControl.authorizationCheck: #NOT_REQUIRED

define table function /ZUORA001/TF_CPBCLOG
returns
{
  client             : abap.clnt;
  CustomerId         : /zuora001/decustomerid;
  CapabilityId      : /zuora001/decapbid;
  CapabilityName    : /zuora001/decapb_name;
  ValidFrom         : /zuora001/devalid_from;
  ValidFrom_old     : /zuora001/devalid_from;
  ValidTo           : /zuora001/devalid_to;
  ValidTo_old       : /zuora001/devalid_to;
  ActivatedDate     : /zuora001/deactivated_date;
  ActivatedDate_old : /zuora001/deactivated_date;
  ExpiryDate        : /zuora001/deexpiry_date;
  ExpiryDate_old    : /zuora001/deexpiry_date;
  Active             : /zuora001/deactive;
  Active_old         : /zuora001/deactive;
  Status             : /zuora001/destatus;
  Status_old         : /zuora001/destatus;
  CreatedBy          : abp_creation_user;
  CreatedAt          : abp_creation_tstmpl;
  LocalChangedBy     : abp_locinst_lastchange_user;
  LocalLastChangedAt : abp_locinst_lastchange_tstmpl;
  LastChangedAt      : abp_lastchange_tstmpl;
}
implemented by method
  /zuora001/cl_data_log=>custcapb;