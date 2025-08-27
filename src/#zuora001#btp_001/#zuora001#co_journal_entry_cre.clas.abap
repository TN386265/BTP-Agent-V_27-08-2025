class /ZUORA001/CO_JOURNAL_ENTRY_CRE definition
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
  methods JOURNAL_ENTRY_CREATE_REQUEST_C
    importing
      !INPUT type /ZUORA001/JOURNAL_ENTRY_BULK_C
    exporting
      !OUTPUT type /ZUORA001/JOURNAL_ENTRY_BULK_1
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS /ZUORA001/CO_JOURNAL_ENTRY_CRE IMPLEMENTATION.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = '/ZUORA001/CO_JOURNAL_ENTRY_CRE'
    logical_port_name   = logical_port_name
    destination         = destination
  ).

  endmethod.


  method JOURNAL_ENTRY_CREATE_REQUEST_C.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'JOURNAL_ENTRY_CREATE_REQUEST_C'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
