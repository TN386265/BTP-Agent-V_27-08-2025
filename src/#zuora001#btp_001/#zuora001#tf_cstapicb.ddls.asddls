@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'CustwiseAPICall with CapabilityAnalytics'

@AccessControl.authorizationCheck: #NOT_REQUIRED

define table function /ZUORA001/TF_CSTAPICB
  with parameters
    p_customer_id : /zuora001/delongchar,
    p_from_date   : /zuora001/defdate,
    p_to_date     : /zuora001/detdate,
    p_capbwise    : /zuora001/deyn
returns
{
  client         : abap.clnt;
  CustomerId     : /zuora001/decustomerid;
  CustomerName   : /zuora001/decust_name;
  CapabilityId   : /zuora001/decapbid;
  CapabilityName : /zuora001/decapb_name;
  FiscYear       : abap.numc(4);
  FisPeriod      : abap.numc(2);
  SuccessCalls   : abap.int4;
  FailureCalls   : abap.int4;
  TotalCalls     : abap.int4;
  SuccessRate    : abap.dec(10,2);
  FailureRate    : abap.dec(10,2);
}
implemented by method
  /ZUORA001/CL_ANALYTICS_M=>get_cust_apicapb;