@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Customer-wise API Call analytics'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_CSTAPICA
  with parameters
    p_customer_id   : /zuora001/delongchar,
    p_from_date     : /zuora001/defdate,
    p_to_date       : /zuora001/detdate,
    p_capability_id : /zuora001/delongchar
  as select from /ZUORA001/TF_CSTAPICA( p_customer_id :$parameters.p_customer_id, p_from_date: $parameters.p_from_date, p_to_date: $parameters.p_to_date, p_capability_id: $parameters.p_capability_id )
{
  key CustomerId,
  key CustomerName,
  key FiscYear,
  key FisPeriod,
      SuccessCalls,
      FailureCalls,
      SuccessCalls + FailureCalls as TotalCalls
}
