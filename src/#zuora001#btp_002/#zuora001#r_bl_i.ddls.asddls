@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item'
@Metadata.ignorePropagatedAnnotations: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /ZUORA001/R_BL_I
  as select from /zuora001/t_bl_i
  association to parent /ZUORA001/R_BL_H as CREATORDATAIN
  on $projection.je_uid = CREATORDATAIN.je_uid
    and $projection.customer_id =  CREATORDATAIN.customer_id
//    and $projection.bl_doc_number =  CREATORDATAIN.bl_doc_number

{   key je_uid as je_uid,
    key customer_id as customer_id,
    key itemno_acc as Itemnobcc,
    bl_doc_number as bl_doc_number,
    destination_system as  destination_system,
    destination_name as destination_name ,
      salesorg           as SALESORG,
      distr_chan         as DISTR_CHAN,
      division           as DIVISION,
      doc_type           as DOC_TYPE,
      ordbilltyp         as ORDBILLTYP,
      bill_date          as BILL_DATE,
      sold_to            as SOLD_TO,
      item_categ         as ITEM_CATEG,
      acctasgnmt         as ACCTASGNMT,
      price_date         as PRICE_DATE,
      country            as COUNTRY,
      plant              as PLANT,
      bill_to            as BILL_TO,
      payer              as PAYER,
      ship_to            as SHIP_TO,
      ref_doc            as REF_DOC,
      material           as MATERIAL,
      req_qty            as REQ_QTY,
      currency           as CURRENCY,
      short_text         as SHORT_TEXT,
      taxcl_1mat         as TAXCL_1MAT,
      ref_item           as REF_ITEM,
      stat_group         as STAT_GROUP,
      no_matmast         as NO_MATMAST,
      addr_no            as ADDR_NO,
      title              as TITLE,
      name               as NAME,
      name_2             as NAME_2,
      postl_code         as POSTL_CODE,
      consumctry         as CONSUMCTRY,
      city               as CITY,
      district           as DISTRICT,
      street             as STREET,
      region             as REGION,
      prod_hier          as PROD_HIER,
      sales_unit         as SALES_UNIT,
      profit_ctr         as PROFIT_CTR,
      taxjurcode         as TAXJURCODE,
      purch_ord          as PURCH_ORD,
      doc_number         as DOC_NUMBER,
      itm_number         as ITM_NUMBER,
      origindoc          as ORIGINDOC,
      item               as ITEM,
      created_by         as CREATED_BY,
      material_external  as MATERIAL_EXTERNAL,
      material_guid      as MATERIAL_GUID,
      material_version   as MATERIAL_VERSION,
      incoterms1         as INCOTERMS1,
      incoterms2         as INCOTERMS2,
      exchange_rate      as EXCHANGE_RATE,
      payment_terms      as PAYMENT_TERMS,
      hg_lv_item         as HG_LV_ITEM,
      ref_doc_ca         as REF_DOC_CA,
      orderid            as ORDERID,
      profit_segm_no     as PROFIT_SEGM_NO,
      costcenter         as COSTCENTER,
      wbs_elem           as WBS_ELEM,
      tax_depart_cty     as TAX_DEPART_CTY,
      tax_dest_cty       as TAX_DEST_CTY,
      serv_date          as SERV_DATE,
      cont_acct          as CONT_ACCT,
      parallel_qty       as PARALLEL_QTY,
      parallel_uom       as PARALLEL_UOM,
      ref_doc_ca_long    as REF_DOC_CA_LONG,
      incotermsv         as INCOTERMSV,
      incoterms2l        as INCOTERMS2L,
      incoterms3l        as INCOTERMS3L,
      material_long      as MATERIAL_LONG,
     CREATORDATAIN

}
