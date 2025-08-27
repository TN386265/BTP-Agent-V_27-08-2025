@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE

@EndUserText.label: 'Cust-wise API Call with Capab&Dest'

@AccessControl.authorizationCheck: #NOT_REQUIRED

//The function-get_cust_apicapdV4 logic is same as get_cust_apicapd. Added to handle the length issue of destination system-from 10 to 30

define table function /ZUORA001/TF_CSTAPIDV4
  with parameters
    p_customer_id : /zuora001/delongchar,
    p_from_date   : /zuora001/defdate,
    p_to_date     : /zuora001/detdate
returns
{
  client            : abap.clnt;
  CustomerId        : /zuora001/decustomerid;
  CustomerName      : /zuora001/decust_name;
  CapabilityId      : /zuora001/decapbid;
  CapabilityName    : /zuora001/decapb_name;
  DestinationSystem : /zuora001/dedest_sys;
  DestinationName   : /zuora001/dedest_name;
  FiscYear          : abap.numc(4);
  FisPeriod         : abap.numc(2);
  SuccessCalls      : abap.int4;
  FailureCalls      : abap.int4;
}
implemented by method
  /ZUORA001/CL_ANALYTICS_M=>get_cust_apicapdV4;