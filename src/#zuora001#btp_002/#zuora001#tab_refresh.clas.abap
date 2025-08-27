CLASS /zuora001/tab_refresh DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun .
    CLASS-METHODS:
      delete_all_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ZUORA001/TAB_REFRESH IMPLEMENTATION.


  METHOD delete_all_data.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    DELETE FROM /zuora001/t_bl_h.
    DELETE FROM /zuora001/t_bl_i.
    DELETE FROM /zuora001/t_bl_c.
    DELETE FROM /zuora001/t_bl_v.
    DELETE FROM /zuora001/t_bl_n.
    DELETE FROM /zuora001/t_bl_e.
    DELETE FROM /zuora001/t_bl_r.
    DELETE FROM /zuora001/t_bl_s.
    DELETE FROM /zuora001/t_bl_t.

    COMMIT WORK.
  ENDMETHOD.
ENDCLASS.
