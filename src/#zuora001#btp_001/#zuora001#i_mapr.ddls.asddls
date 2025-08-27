@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mapping value column interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/I_MAPR
  with parameters
    pmap_type : /zuora001/devmaptype
  as select from /zuora001/t_mapr
{
  key mapping_type          as MappingType,
  key valuemap_capability   as ValuemapCapability,
  key valuemap_col_id       as ValuemapColId,
  key valid_from            as ValidFrom,
      valid_to              as ValidTo,
      valuemap_name         as ValuemapName,
      item_sub_category     as ItemSubCategory,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_changed_by      as LocalChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}
where
      mapping_type = $parameters.pmap_type
  and status       = '1'
