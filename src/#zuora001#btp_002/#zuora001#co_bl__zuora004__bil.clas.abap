class /ZUORA001/CO_BL__ZUORA004__BIL definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to IF_PROXY_DESTINATION optional
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    preferred parameter LOGICAL_PORT_NAME
    raising
      CX_AI_SYSTEM_FAULT .
  methods ZUORA004__BILLING_DOC_CREATE
    importing
      !INPUT type /ZUORA001/BL__ZUORA004__BILLI1
    exporting
      !OUTPUT type /ZUORA001/BL__ZUORA004__BILLIN
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS /ZUORA001/CO_BL__ZUORA004__BIL IMPLEMENTATION.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = '/ZUORA001/CO_BL__ZUORA004__BIL'
    logical_port_name   = logical_port_name
    destination         = destination
  ).

  endmethod.


  method ZUORA004__BILLING_DOC_CREATE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ZUORA004__BILLING_DOC_CREATE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
