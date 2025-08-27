@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'List with Capab Links'
define table function /ZUORA001/TF_CSTLIST
  with parameters
    p_capability_id : /zuora001/delongchar
returns
{
  client             : abap.clnt;
  CustomerId         : /zuora001/decustomerid;
  ValidFrom          : /zuora001/devalid_from;
  ValidTo            : /zuora001/devalid_to;
  CustomerName       : /zuora001/decust_name;
  ActivatedDate      : /zuora001/deactivated_date;
  ExpiryDate         : /zuora001/deexpiry_date;
  Active             : /zuora001/deactive;
  Status             : /zuora001/destatus;
  CreatedBy          : abp_creation_user;
  CreatedAt          : abp_creation_tstmpl;
  LocalChangedBy     : abp_locinst_lastchange_user;
  LocalLastChangedAt : abp_locinst_lastchange_tstmpl;
  LastChangedAt      : abp_lastchange_tstmpl;

}
implemented by method
  /ZUORA001/CL_ANALYTICS_M=>get_cust_list;