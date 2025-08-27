
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Domain valeus'
@Metadata.ignorePropagatedAnnotations: true

@AbapCatalog.extensibility: {
extensible: true,
elementSuffix: 'ZDM',
allowNewDatasources: false,
dataSources: [ 'val' ],
quota:{
maximumFields: 250,
maximumBytes: 2500
}
}

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity /ZUORA001/DM_VALUES
  with parameters
    p_dom_name : sxco_ad_object_name
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE( p_domain_name: $parameters.p_dom_name ) as val
  association [0..1] to DDCDS_CUSTOMER_DOMAIN_VALUE_T as _txt on  val.domain_name    = _txt.domain_name
                                                              and val.value_position = _txt.value_position
                                                              and _txt.language      = $session.system_language
{
  key val.domain_name,
  key val.value_position,
      val.value_low,
      val.value_high,
      _txt( p_domain_name : $parameters.p_dom_name ).text as Descr
}
