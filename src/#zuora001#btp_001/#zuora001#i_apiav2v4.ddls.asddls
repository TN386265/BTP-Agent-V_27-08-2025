@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'APICallAnalytics interface- for auth obj'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

// The function-get_cust_apicapdv2v4 logic is same as get_cust_apicapdv2. Added to handle the length issue of destination system-from 10 to 30

define view entity /ZUORA001/I_APIAV2V4
  with parameters
    p_from_date : /zuora001/defdate,
    p_to_date   : /zuora001/detdate
  as select from /ZUORA001/TF_CSTAPIDV2V4( p_from_date:$parameters.p_from_date , p_to_date:$parameters.p_to_date  )
{
  key CustomerId,
  key CustomerName,
  key CapabilityId,
  key CapabilityName,
  key DestinationSystem,
  key DestinationName,
  key FiscYear,
  key FisPeriod,
      SuccessCalls,
      FailureCalls,
      SuccessCalls + FailureCalls as TotalCalls
}
