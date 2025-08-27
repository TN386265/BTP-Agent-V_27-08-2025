CLASS /zuora001/s4_bill_post DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES: BEGIN OF e_msg,
             message TYPE string,
             inv_no  TYPE /zuora001/t_je_h-je_doc_number,
           END OF e_msg.
      .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/S4_BILL_POST IMPLEMENTATION.
ENDCLASS.
