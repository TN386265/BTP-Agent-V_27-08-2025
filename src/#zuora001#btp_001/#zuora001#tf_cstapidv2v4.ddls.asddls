@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE

@EndUserText.label: 'Customer-wise APICall-CapabDestAnalytics'

@AccessControl.authorizationCheck: #NOT_REQUIRED

// The function-get_cust_apicapdv2v4 logic is same as get_cust_apicapdv2. Added to handle the length issue of destination system-from 10 to 30

define table function /ZUORA001/TF_CSTAPIDV2V4
  with parameters
    p_from_date : /zuora001/defdate,
    p_to_date   : /zuora001/detdate
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
  /ZUORA001/CL_ANALYTICS_M=>get_cust_apicapdv2v4;