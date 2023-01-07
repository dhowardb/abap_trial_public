*"* use this source file for your ABAP unit test classes

CLASS ltd_constructor_injection DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES:
      zif_cash_provider_howard PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_constructor_injection IMPLEMENTATION.

  METHOD zif_cash_provider_howard~get_notes.
    r_change = VALUE #( ( amount = 1 type = zcl_constructor_injection_how=>money-coin )
                        ( amount = 5 type = zcl_constructor_injection_how=>money-coin )
                        ( amount = 4 type = zcl_constructor_injection_how=>money-coin ) ).
  ENDMETHOD.

ENDCLASS.

CLASS ltc_get_amount DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.

    DATA: cut TYPE REF TO zcl_constructor_injection_how.

    METHODS setup.

    METHODS:
      assert_coins
        IMPORTING
          i_input  TYPE i
          i_return TYPE i,
      assert_notes
        IMPORTING
          i_input  TYPE i
          i_return TYPE i,
      assert_change
        IMPORTING
          i_input  TYPE i
          i_return TYPE zcl_constructor_injection_how=>tt_change,
      assert_error_changes
        IMPORTING
          i_input TYPE i,
      assert_change_nonsorted
        IMPORTING
          i_input  TYPE i
          i_return TYPE zcl_constructor_injection_how=>tt_change,
      compare_table_any_order
        IMPORTING
          i_actual_table    TYPE zcl_constructor_injection_how=>tt_change
          i_expected_table  TYPE zcl_constructor_injection_how=>tt_change
        RETURNING
          VALUE(r_is_equal) TYPE abap_bool.

    METHODS:
      "! <p>Verify return for coins</p>
      verify_coin FOR TESTING RAISING cx_static_check,
      "! <p>Verify return for notes</p>
      verify_notes FOR TESTING RAISING cx_static_check,
      "! <p>Verify return for change</p>
      verify_change FOR TESTING RAISING cx_static_check,
      "! <p>Verify return for change error</p>
      verify_change_error FOR TESTING RAISING cx_static_check.

    METHODS:
      "! <p>7 EUR 1 note(5) and 1 coin(2)</p>
      amount_7_note_1_coin_2 FOR TESTING RAISING cx_static_check,
      "! <p>Verify return for change without sorting dependency</p>
      verify_change_nonsorted FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_get_amount IMPLEMENTATION.

  METHOD setup.
*    cut = NEW #( ).
    DATA(cash_provider) = NEW ltd_constructor_injection( ).
    cut = NEW #( cash_provider ).
  ENDMETHOD.

  METHOD assert_coins.
    cl_abap_unit_assert=>assert_equals( act = cut->get_amount_in_coins( i_input )
                                        exp = i_return ).
  ENDMETHOD.

  METHOD assert_notes.
    cl_abap_unit_assert=>assert_equals( act = cut->get_amount_in_notes( i_input )
                                        exp = i_return ).
  ENDMETHOD.

  METHOD assert_change.
    cl_abap_unit_assert=>assert_equals( act = cut->get_change( i_input )
                                        exp = i_return ).
  ENDMETHOD.

  METHOD assert_error_changes.
    cl_abap_unit_assert=>assert_equals( act = cut->get_change( i_input )
                                        exp = VALUE zcl_constructor_injection_how=>tt_change(
                                                  ( amount = zcl_constructor_injection_how=>error_value-c_amount
                                                    type   = zcl_constructor_injection_how=>error_value-c_type ) ) ).
  ENDMETHOD.

  METHOD assert_change_nonsorted.

    DATA(is_equal) = compare_table_any_order(
      i_actual_table   = cut->get_change( i_input )
      i_expected_table = i_return ).

    cl_abap_unit_assert=>assert_equals( act = is_equal
                                        exp = abap_true ).
  ENDMETHOD.

  METHOD compare_table_any_order.
    DATA(lt_difference) = FILTER #( i_actual_table EXCEPT IN i_expected_table
                           WHERE amount = amount
                             AND   type = type ).

    IF lines( lt_difference ) = 0.
      r_is_equal = abap_true.
    ELSE.
      r_is_equal = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD verify_coin.
    assert_coins( i_input = 1 i_return = 1 ).
    assert_coins( i_input = 2 i_return = 2 ).
    assert_coins( i_input = 29 i_return = 4 ).
  ENDMETHOD.

  METHOD verify_notes.
    assert_notes( i_input = 4 i_return = 0 ).
    assert_notes( i_input = 29 i_return = 25 ).
  ENDMETHOD.

  METHOD verify_change.

    "special case
    cl_abap_unit_assert=>assert_initial( cut->get_change( 0 ) ).

    assert_change( i_input  = 1
                   i_return = VALUE #( ( amount = 1 type = cut->money-coin ) ) ).

    assert_change( i_input  = 2
                   i_return = VALUE #( ( amount = 2 type = cut->money-coin ) ) ).

    assert_change( i_input  = 5
                   i_return = VALUE #( ( amount = 5 type = cut->money-note ) ) ).

    assert_change( i_input  = 7
                   i_return = VALUE #( ( amount = 5 type = cut->money-note )
                                       ( amount = 2 type = cut->money-coin ) ) ).

    assert_change( i_input  = 8
                   i_return = VALUE #( ( amount = 5 type = cut->money-note )
                                       ( amount = 2 type = cut->money-coin )
                                       ( amount = 1 type = cut->money-coin ) ) ).

    assert_change( i_input  = 9
                   i_return = VALUE #( ( amount = 5 type = cut->money-note )
                                       ( amount = 2 type = cut->money-coin )
                                       ( amount = 1 type = cut->money-coin )
                                       ( amount = 1 type = cut->money-coin ) ) ).

    assert_change( i_input  = 10
                   i_return = VALUE #( ( amount = 10 type = cut->money-note ) ) ).

    assert_change( i_input  = 15
                   i_return = VALUE #( ( amount = 10 type = cut->money-note )
                                       ( amount = 5 type = cut->money-note ) ) ).

    assert_change( i_input  = 20
                   i_return = VALUE #( ( amount = 20 type = cut->money-note ) ) ).

    assert_change( i_input  = 50
                   i_return = VALUE #( ( amount = 50 type = cut->money-note ) ) ).

    assert_change( i_input  = 85
                   i_return = VALUE #( ( amount = 50 type = cut->money-note )
                                       ( amount = 20 type = cut->money-note )
                                       ( amount = 10 type = cut->money-note )
                                       ( amount = 5 type = cut->money-note ) ) ).

    assert_change( i_input  = 100
                   i_return = VALUE #( ( amount = 100 type = cut->money-note ) ) ).

    assert_change( i_input  = 200
                   i_return = VALUE #( ( amount = 200 type = cut->money-note ) ) ).

    assert_change( i_input  = 500
                   i_return = VALUE #( ( amount = 500 type = cut->money-note ) ) ).

    assert_change( i_input  = 688
                   i_return = VALUE #( ( amount = 500 type = cut->money-note )
                                       ( amount = 100 type = cut->money-note )
                                       ( amount = 50 type = cut->money-note )
                                       ( amount = 20 type = cut->money-note )
                                       ( amount = 10 type = cut->money-note )
                                       ( amount = 5 type = cut->money-note )
                                       ( amount = 2 type = cut->money-coin )
                                       ( amount = 1 type = cut->money-coin ) ) ).
  ENDMETHOD.

  METHOD verify_change_error.
    assert_error_changes( i_input = -1 ).
    assert_error_changes( i_input = -15 ).
  ENDMETHOD.

  METHOD verify_change_nonsorted.

    assert_change_nonsorted( i_input  = 85
                             i_return = VALUE #( ( amount = 50 type = cut->money-note )
                                                 ( amount = 10 type = cut->money-note )
                                                 ( amount = 5 type = cut->money-note )
                                                 ( amount = 20 type = cut->money-note )
                                                  ) ).

    assert_change( i_input  = 688
                   i_return = VALUE #( ( amount = 50 type = cut->money-note )
                                       ( amount = 100 type = cut->money-note )
                                       ( amount = 10 type = cut->money-note )
                                       ( amount = 2 type = cut->money-coin )
                                       ( amount = 500 type = cut->money-note )
                                       ( amount = 20 type = cut->money-note )
                                       ( amount = 5 type = cut->money-note )
                                       ( amount = 1 type = cut->money-coin ) ) ).
  ENDMETHOD.

  METHOD amount_7_note_1_coin_2.

    assert_change( i_input  = 7
                   i_return = VALUE #( ( amount = 5 type = cut->money-note )
                                       ( amount = 2 type = cut->money-coin ) ) ).

  ENDMETHOD.
ENDCLASS.
