class /ZUORA001/CO_JE_ECC__ZUORA004 definition
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
  methods ZUORA004__ACC_DOCUMENT_POST
    importing
      !INPUT type /ZUORA001/JE_ECC__ZUORA004__A1
    exporting
      !OUTPUT type /ZUORA001/JE_ECC__ZUORA004__AC
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS /ZUORA001/CO_JE_ECC__ZUORA004 IMPLEMENTATION.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = '/ZUORA001/CO_JE_ECC__ZUORA004'
    logical_port_name   = logical_port_name
    destination         = destination
  ).

  endmethod.


  method ZUORA004__ACC_DOCUMENT_POST.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ZUORA004__ACC_DOCUMENT_POST'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
