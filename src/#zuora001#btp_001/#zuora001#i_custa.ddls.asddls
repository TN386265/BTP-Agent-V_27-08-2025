@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Interface for customer - view entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@AbapCatalog.extensibility: {
extensible: true,
elementSuffix: 'ZM0',
allowNewDatasources: false,
dataSources: [ 'cust' ],
quota:{
maximumFields: 250,
maximumBytes: 2500
}
}

define view entity /ZUORA001/I_CUSTA
  as select from /zuora001/t_cust as cust
{
  key cust.customer_id           as CustomerId,
  key cust.valid_from            as ValidFrom,
      cust.valid_to              as ValidTo,
      cust.customer_name         as CustomerName,
      cust.activated_date        as ActivatedDate,
      cust.expiry_date           as ExpiryDate,
      cust.active                as Active,
      cust.status                as Status,
      cust.created_by            as CreatedBy,
      cust.created_at            as CreatedAt,
      cust.local_changed_by      as LocalChangedBy,
      cust.local_last_changed_at as LocalLastChangedAt,
      cust.last_changed_at       as LastChangedAt
}
