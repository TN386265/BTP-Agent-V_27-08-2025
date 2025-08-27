@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Destination data log'

@AccessControl.authorizationCheck: #NOT_REQUIRED

define table function /ZUORA001/TF_DESTLOG
returns
{
  client              : abap.clnt;
  CustomerId          : /zuora001/decustomerid;
  Destinationid       : /zuora001/dedestid;
  ValidFrom           : /zuora001/devalid_from;
  ValidFrom_old       : /zuora001/devalid_from;
  ValidTo             : /zuora001/devalid_to;
  ValidTo_old         : /zuora001/devalid_to;
  DestinationName     : /zuora001/dedest_name;
  DestinationName_old : /zuora001/dedest_name;
  Description         : /zuora001/dedest_desc;
  Description_old     : /zuora001/dedest_desc;
  CapabilityId        : /zuora001/decapbid;
  CapabilityId_old    : /zuora001/decapbid;
  CapabilityName      : /zuora001/decapb_name;
  CapabilityName_old  : /zuora001/decapb_name;
  DestUsrl            : abap.string(0);
  DestUsrl_old        : abap.string(0);
  DestType            : /zuora001/dedest_type;
  DestType_old        : /zuora001/dedest_type;
  ProxyType           : /zuora001/deproxy_type;
  ProxyType_old       : /zuora001/deproxy_type;
  AuthType            : /zuora001/deauth_type;
  AuthType_old        : /zuora001/deauth_type;
  AuthUser            : /zuora001/deauth_user;
  AuthUser_old        : /zuora001/deauth_user;
  SystemId            : /zuora001/desystem_id;
  SystemId_old        : /zuora001/desystem_id;
  LandScape           : /zuora001/deapi_landscape;
  LandScape_old       : /zuora001/deapi_landscape;
  Status              : /zuora001/destatus;
  Status_old          : /zuora001/destatus;
  CreatedBy           : abp_creation_user;
  CreatedAt           : abp_creation_tstmpl;
  LocalChangedBy      : abp_locinst_lastchange_user;
  LocalLastChangedAt  : abp_locinst_lastchange_tstmpl;
  LastChangedAt       : abp_lastchange_tstmpl;
}
implemented by method
  /zuora001/cl_data_log=>destination;