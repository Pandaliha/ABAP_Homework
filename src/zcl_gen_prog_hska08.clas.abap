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
*   delete existing entries in the database table
    DELETE FROM zprog_hska08.

*   fill internal travel table (itab)
itab = VALUE #(
  ( mykey = '02D5290E594C1EDA93815057FD946624' language_id = '00000022' language_name = 'Java' description = 'Java ist eine Sprache die auf verschiedenen Plattformen läuft, für die es eine Java Virtual Machine gibt. ' snippet =
'System.out.println("Hello World");' rating = '2'
   favourite = 'F' created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB0B' language_id = '00000103' language_name = 'Python' description = 'Python hat sich in den letzten Jahren im Grunde als Eierlegende Wollmilchsau etabliert.' snippet = 'print("Hello World")' rating = '3'
   favourite = '' created_by = 'MUSTERMANN' created_at = '20190613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' )
   ( mykey = '02D5290E594C1EDA93858EED2DA2EB10' language_id = '00000001' language_name = 'JavaScript' description = 'Wenn es Ihnen also eher darum geht, schicke, interaktive Webseiten zu stricken, ist JavaScript keine schlechte Alternative.' snippet =
'alert( "Hello, world!" );' rating = '3'
   favourite = '' created_by = 'MUSTERMANN' created_at = '20190613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' )
   ( mykey = '02D5290E594C1EDA93858EED2DA2EB11' language_id = '00000002' language_name = 'C, C++, C#' description = 'C, C++, C# kommt hauptsächlich im Server/Desktop- und im IoT-Umfeld vor.' snippet = 'printf("Hello World\n");' rating = '3'
   favourite = '' created_by = 'MUSTERMANN' created_at = '20190613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' )
   ( mykey = '02D5290E594C1EDA93858EED2DA2EB12' language_id = '00000003' language_name = 'TypeScript' description = 'Im Gegensatz zu JavaScript ist TypeScript statisch typisiert und gibt euch mehr Kontrolle über euren eigenen Code.' snippet =
'console.log("Hello World");' rating = '3'
   favourite = '' created_by = 'MUSTERMANN' created_at = '20190613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' )
   ( mykey = '02D5290E594C1EDA93858EED2DA2EB13' language_id = '00000004' language_name = 'Dart' description =
'Dart ist eine Programmiersprache aus dem Hause Google, deren Entwickler vor allem die Verwendung in Web-Browsern dafür ins Auge gefasst hatten.' snippet = 'print("Hello World!");' rating = '3'
   favourite = '' created_by = 'MUSTERMANN' created_at = '20190613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' )
   ( mykey = '02D5290E594C1EDA93858EED2DA2EB15' language_id = '00000006' language_name = 'Kotlin' description = 'Kotlin ist erst ein paar Jahre alt und hat somit viele moderne Features an Bord, die bei Java erst nach und nach hinzu kamen.' snippet =
'println("Hello World!")' rating = '3'
   favourite = '' created_by = 'MUSTERMANN' created_at = '20190613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' )
   ( mykey = '02D5290E594C1EDA93858EED2DA2EB16' language_id = '00000007' language_name = 'Go' description =
'Die Open-Source-Programmiersprache Go wurde von Google aus Unzufriedenheit mit Java und C++ entwickelt. Sie ist vor allem für Cloud-Computing relevant.' snippet = 'fmt.Println("hello world")' rating = '3'
   favourite = '' created_by = 'MUSTERMANN' created_at = '20190613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' )
  ).

*   insert the new table entries
    INSERT zprog_hska08 FROM TABLE @itab.

*    DATA(lv_url) = |https://raw.githubusercontent.com/Pandaliha/ABAP_Homework/master/programming_languages.json|.
*    TRY.
*
*        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( lv_url ).
*        DATA(lo_http) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*
*        DATA(lo_request) = lo_http->get_http_request( ).
*
*        DATA(lo_reponse) = lo_http->execute( i_method = if_web_http_client=>get ).
*
*        out->write( lo_reponse->get_text( ) ).
*
*      CATCH cx_root INTO DATA(lx_root).
*
*
*
*        out->write( lx_root->get_longtext( ) ).
*
*    ENDTRY.

*   check the result
    SELECT * FROM zprog_hska08 INTO TABLE @itab.
    out->write( sy-dbcnt ).
    out->write( 'Prog language data inserted successfully!').

  ENDMETHOD.
ENDCLASS.
