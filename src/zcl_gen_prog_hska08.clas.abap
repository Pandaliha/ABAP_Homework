CLASS zcl_gen_prog_hska08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gen_prog_hska08 IMPLEMENTATION.
 METHOD if_oo_adt_classrun~main.
    DATA:itab TYPE TABLE OF zprog_hska08.

*   read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).

*   fill internal travel table (itab)
    itab = VALUE #(
  ( mykey = '02D5290E594C1EDA93815057FD946624' language_id = '00000022' language_name = 'C#' description = 'Blabla' snippet = 'System.out.println("Hello World");' rating = '2')
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB0B' language_id = '00000103' language_name = 'Java' description = 'Blabla' snippet = 'System.out.println("Hello World");' rating = '2')
  ).

*   delete existing entries in the database table
    DELETE FROM zprog_hska08.

*   insert the new table entries
    INSERT zprog_hska08 FROM TABLE @itab.

*   check the result
    SELECT * FROM zprog_hska08 INTO TABLE @itab.
    out->write( sy-dbcnt ).
    out->write( 'Prog language data inserted successfully!').

  ENDMETHOD.
ENDCLASS.