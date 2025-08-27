@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Customer-wise API Call analytics'
define table function /ZUORA001/TF_CSTAPICA
  with parameters
    p_customer_id   : /zuora001/delongchar,
    p_from_date     : /zuora001/defdate,
    p_to_date       : /zuora001/detdate,
    p_capability_id : /zuora001/delongchar
returns
{
  client       : abap.clnt;
  CustomerId   : /zuora001/decustomerid;
  CustomerName : /zuora001/decust_name;
  FiscYear     : abap.numc(4);
  FisPeriod    : abap.numc(2);
  SuccessCalls : abap.int4;
  FailureCalls : abap.int4;
}
implemented by method
  /ZUORA001/CL_ANALYTICS_M=>get_cust_apia;