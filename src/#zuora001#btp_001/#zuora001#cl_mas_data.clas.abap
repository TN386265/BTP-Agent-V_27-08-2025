CLASS /zuora001/cl_mas_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/CL_MAS_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt  TYPE TABLE OF /zuora001/t_mapr,
          lvc TYPE /zuora001/t_mapr-created_by,
          lvt TYPE /zuora001/t_mapr-created_at.

    GET TIME STAMP FIELD lvt.
    lvc = sy-uname.

    DELETE FROM /zuora001/t_mapr WHERE mapping_type = 'H' or mapping_type = 'I'.

    lt = VALUE #(
    ( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'ACC_PRINCIPLE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    )
    ).

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'AC_DOC_NO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'BILL_CATEGORY'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'BUS_ACT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'COMPO_ACC'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'COMP_CODE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'DOC_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'DOC_STATUS'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'DOC_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'ECS_ENV'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'EXCHANGE_RATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'FISC_YEAR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'FIS_PERIOD'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'HEADER_TXT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'INVOICE_REC_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'NEG_POSTNG'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'OBJ_KEY'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'OBJ_KEY_INV'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'OBJ_KEY_R'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'OBJ_SYS'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'OBJ_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'PARTIAL_REV'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'PSTNG_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'REASON_REV'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'REF_DOC_NO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'REF_DOC_NO_LONG'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'TRANS_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'USERNAME'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'H'
      valuemap_name = 'VATDATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.


    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ACCT_KEY'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ACCT_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ACTIVITY'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ACTTYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ALLOC_NMBR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ASSET_NO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ASVAL_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'BASE_UOM'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'BASE_UOM_ISO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'BILLING_PERIOD_END_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'BILLING_PERIOD_START_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'BILL_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'BUDGET_PERIOD'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'BUS_AREA'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'BUS_SCENARIO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'CMM_ITEM'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'CMM_ITEM_LONG'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.


    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'COMP_CODE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'COND_CATEGORY'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'COND_COUNT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'COND_ST_NO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'COND_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'COSTCENTER'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'COSTOBJECT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'CO_BUSPROC'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'CSHDIS_IND'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'CS_TRANS_T'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'CUSTOMER'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'DE_CRE_IND'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'DISTR_CHAN'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'DIVISION'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'DOC_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ENTRY_QNT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ENTRY_UOM'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ENTRY_UOM_ISO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'EXPENSE_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'EXT_OBJECT_ID'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'FASTPAY'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'FISC_YEAR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'FIS_PERIOD'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'FM_AREA'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'FUNC_AREA'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'FUNC_AREA_LONG'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'FUND'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'FUNDS_CTR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'GL_ACCOUNT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'GRANT_NBR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'GROSS_WT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'HOUSEBANK'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'HOUSEBANKACCOUNT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'INV_QTY'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'INV_QTY_SU'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ITEMNO_TAX'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ITEM_CAT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ITEM_TEXT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ITM_NUMBER'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'LOG_PROC'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'MATERIAL'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'MATERIAL_LONG'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'MATL_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'MEASURE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'MVT_IND'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'NETWORK'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'NET_WEIGHT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ORDERID'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ORDER_ITNO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ORIG_GROUP'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

    APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ORIG_MAT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PARTNER_BUDGET_PERIOD'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.


   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PARTNER_FUND'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PARTNER_GRANT_NBR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PARTNER_SEGMENT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PART_ACCT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PART_PRCTR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PAYMENT_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PLANT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PMNTTRMS'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PO_ITEM'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PO_NUMBER'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PO_PR_QNT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PO_PR_UOM'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PO_PR_UOM_ISO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PPA_EX_IND'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PROFIT_CTR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PROGRAM_PROFILE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'PSTNG_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'P_EL_PRCTR'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'QUANTITY'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'REF_KEY_1'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'REF_KEY_2'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'REF_KEY_3'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'RES_DOC'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'RES_ITEM'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'REVAL_IND'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'ROUTING_NO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SALESORG'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SALES_GRP'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SALES_OFF'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SALES_ORD'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SALES_UNIT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SALES_UNIT_ISO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SEGMENT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SERIAL_NO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SOLD_TO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'STAT_CON'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'SUB_NUMBER'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'S_ORD_ITEM'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'TAXJURCODE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'TAX_CODE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.


   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'TRADE_ID'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'TR_PART_BA'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'UNIT_OF_WT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'UNIT_OF_WT_ISO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'VALUE_DATE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'VAL_AREA'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'VAL_TYPE'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'VENDOR_NO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'VOLUME'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'VOLUMEUNIT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'VOLUMEUNIT_ISO'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.

   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'WBS_ELEMENT'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.


   APPEND VALUE #( client = sy-mandt
      mapping_type = 'I'
      valuemap_name = 'XMFRW'
      valid_from = 21112024110319
      valid_to = 31129999160721
      status = '1'
      created_by = lvc
      created_at = lvt
    ) TO lt.


    LOOP AT lt INTO DATA(lw).
      INSERT /zuora001/t_mapr FROM @lw.
    ENDLOOP.



    out->write( 'Inserted' ).

  ENDMETHOD.
ENDCLASS.
