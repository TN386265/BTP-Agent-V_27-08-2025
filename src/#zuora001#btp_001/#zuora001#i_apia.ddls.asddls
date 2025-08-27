@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'APICallAnalytics interface- for auth obj'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_APIA
  with parameters
    p_customer_id : /zuora001/delongchar,
    p_from_date   : /zuora001/defdate,
    p_to_date     : /zuora001/detdate
  as select from /ZUORA001/TF_CSTAPID( p_customer_id:$parameters.p_customer_id , p_from_date: $parameters.p_from_date, p_to_date: $parameters.p_to_date )
{
  key  CustomerId,
  key  CustomerName,
  key  CapabilityId,
  key  CapabilityName,
  key  DestinationSystem,
  key  DestinationName,
  key  FiscYear,
  key  FisPeriod,
       SuccessCalls,
       FailureCalls,
       SuccessCalls + FailureCalls as TotalCalls
}
