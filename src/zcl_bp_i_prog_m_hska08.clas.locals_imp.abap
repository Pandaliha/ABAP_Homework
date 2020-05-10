CLASS lhc_language DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    TYPES tt_language_update TYPE  TABLE FOR UPDATE zi_prog_m_hska08.

    METHODS validatelanguage FOR VALIDATION language~validatelanguage IMPORTING keys FOR language.

    METHODS set_status_completed FOR MODIFY IMPORTING keys FOR ACTION language~acceptfavorite RESULT result.
    METHODS get_features               FOR FEATURES IMPORTING keys REQUEST    requested_features FOR language    RESULT result.
    METHODS calculatelanguagekey FOR DETERMINATION language~calculatelanguagekey IMPORTING keys FOR language.
ENDCLASS.

CLASS lhc_language IMPLEMENTATION.
**********************************************************************
*
* Validate language data when saving language data
*
**********************************************************************
  METHOD validatelanguage.

    READ ENTITY zi_prog_m_hska08\\language FROM VALUE #(
    FOR <root_key> IN keys ( %key     = <root_key>
                                   %control = VALUE #( language_id = if_abap_behv=>mk-on ) ) )
          RESULT DATA(lt_language).

    DATA lt_languages TYPE SORTED TABLE OF zprog_hska08 WITH UNIQUE KEY language_id.

    " Optimization of DB select: extract distinct non-initial customer IDs
    lt_languages = CORRESPONDING #( lt_language DISCARDING DUPLICATES MAPPING language_id = language_id EXCEPT * ).
    DELETE lt_languages WHERE language_id IS INITIAL.
    CHECK lt_languages IS NOT INITIAL.

    " Check if customer ID exist
    SELECT FROM zprog_hska08 FIELDS language_id
      FOR ALL ENTRIES IN @lt_languages
      WHERE language_id = @lt_languages-language_id
      INTO TABLE @DATA(lt_languages_db).
  ENDMETHOD.

********************************************************************************
*
* Implements language action
*
********************************************************************************
  METHOD set_status_completed.
    " Modify in local mode: BO-related updates that are not relevant for authorization checks
    MODIFY ENTITIES OF zi_prog_m_hska08 IN LOCAL MODE
           ENTITY language
              UPDATE FROM VALUE #( FOR key IN keys ( mykey = key-mykey
                                                     favourite = 'F'
                                                      %control-favourite = if_abap_behv=>mk-on
                                                     ) )
           FAILED   failed
           REPORTED reported.

    " Read changed data for action result
    READ ENTITIES OF zi_prog_m_hska08 IN LOCAL MODE
         ENTITY language
         FROM VALUE #( FOR key IN keys (  mykey = key-mykey
                                            %control = VALUE #(
                                            language_id       = if_abap_behv=>mk-on
                                            language_name     = if_abap_behv=>mk-on
                                            description      = if_abap_behv=>mk-on
                                            snippet        = if_abap_behv=>mk-on
                                            rating     = if_abap_behv=>mk-on
                                            favourite     = if_abap_behv=>mk-on
                                            created_by   = if_abap_behv=>mk-on
                                            created_at  = if_abap_behv=>mk-on
                                            last_changed_by     = if_abap_behv=>mk-on
                                            last_changed_at      = if_abap_behv=>mk-on
                                            ) ) )
         RESULT DATA(lt_language).

    result = VALUE #( FOR language IN lt_language ( mykey = language-mykey
                                                %param    = language
                                              ) ).


  ENDMETHOD.
*********************************************************************
*
* the dynamic feature handling for travel instances
**
*********************************************************************************
  METHOD get_features.
    "%control-<fieldname> specifies which fields are read from the entities

    READ ENTITY zi_prog_m_hska08 FROM VALUE #( FOR keyval IN keys
                                                      (  %key                    = keyval-%key
                                                       "  %control-travel_id      = if_abap_behv=>mk-on
                                                         %control-favourite = if_abap_behv=>mk-on
                                                        ) )
                                RESULT DATA(lt_language_result).


    result = VALUE #( FOR ls_language IN lt_language_result
                       ( %key                           = ls_language-%key
                         %features-%action-acceptFavorite = COND #( WHEN ls_language-favourite = 'F'
                                                                    THEN if_abap_behv=>fc-o-disabled ELSE  if_abap_behv=>fc-o-enabled   )
                      ) ).

  ENDMETHOD.

  METHOD calculatelanguagekey.
    SELECT FROM zprog_hska08
        FIELDS MAX( language_id ) INTO @DATA(lv_max_language_id).

    LOOP AT keys INTO DATA(ls_key).
      lv_max_language_id = lv_max_language_id + 1.
      MODIFY ENTITIES OF zi_prog_m_hska08  IN LOCAL MODE
        ENTITY language
          UPDATE SET FIELDS WITH VALUE #( ( mykey     = ls_key-mykey
                                            language_id = lv_max_language_id ) )
          REPORTED DATA(ls_reported).
      APPEND LINES OF ls_reported-language TO reported-language.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
