@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Total customers active'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_CUSTC
  with parameters
    p_capbwise : /zuora001/deyn
  as select from /zuora001/t_cust
{
  key 0      as CapabilityId,
  key sum(1) as cust_count
}
where
      status                 = '1'
  and $parameters.p_capbwise = 'N'

union all

select from /ZUORA001/I_CUSTCAPBR
{
  key CapabilityId,
  key sum(1) as cust_count
}
where
      Status                 = '1'
  and Active                 = '1'
  and $parameters.p_capbwise = 'Y'
group by
  CapabilityId
