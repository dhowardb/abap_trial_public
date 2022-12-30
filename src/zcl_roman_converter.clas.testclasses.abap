*"* use this source file for your ABAP unit test classes


CLASS ltc_roman_to_arabic DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA: cut TYPE REF TO zcl_roman_converter.

    METHODS: setup,
      clear_setup.

    METHODS:
      assert_convert
        IMPORTING
          im_roman  TYPE string
          im_arabic TYPE i,

      assert_error
        IMPORTING
          im_roman TYPE string.

    METHODS:
      verify_single FOR TESTING RAISING cx_static_check,
      verify_additive FOR TESTING RAISING cx_static_check,
      verify_subtractive FOR TESTING RAISING cx_static_check,
      verify_complex FOR TESTING RAISING cx_static_check,
      error_cases FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_roman_to_arabic IMPLEMENTATION.

  METHOD setup.
    "given
    cut = NEW zcl_roman_converter( ).
  ENDMETHOD.

  METHOD assert_convert.
    cl_abap_unit_assert=>assert_equals( act = cut->to_arabic( im_roman )
                                        exp = im_arabic ).
  ENDMETHOD.

  METHOD assert_error.
    cl_abap_unit_assert=>assert_equals( act = cut->to_arabic( im_roman )
                                        exp = zcl_roman_converter=>error_value
*                                        exp = cut->error_value
                                         ).
  ENDMETHOD.

  METHOD verify_single.
    assert_convert( im_roman = '' im_arabic = 0 ).
    assert_convert( im_roman = 'I' im_arabic = 1 ).
    assert_convert( im_roman = 'V' im_arabic = 5 ).
    assert_convert( im_roman = 'X' im_arabic = 10 ).
    assert_convert( im_roman = 'L' im_arabic = 50 ).
    assert_convert( im_roman = 'C' im_arabic = 100 ).
    assert_convert( im_roman = 'D' im_arabic = 500 ).
    assert_convert( im_roman = 'M' im_arabic = 1000 ).
  ENDMETHOD.

  METHOD verify_additive.
    assert_convert( im_roman = 'II' im_arabic = 2 ).
    assert_convert( im_roman = 'III' im_arabic = 3 ).
    assert_convert( im_roman = 'XX' im_arabic = 20 ).
    assert_convert( im_roman = 'XV' im_arabic = 15 ).
    assert_convert( im_roman = 'MM' im_arabic = 2000 ).
  ENDMETHOD.

  METHOD verify_subtractive.
    assert_convert( im_roman = 'IX' im_arabic = 9  ).
    assert_convert( im_roman = 'XC' im_arabic = 90  ).
    assert_convert( im_roman = 'CM' im_arabic = 900  ).
  ENDMETHOD.

  METHOD verify_complex.
    assert_convert( im_roman = 'XIV' im_arabic = 14 ).
    assert_convert( im_roman = 'CMXL' im_arabic = 940 ).
    assert_convert( im_roman = 'CMXLIII' im_arabic = 943 ).
    assert_convert( im_roman = 'MCMXLVII' im_arabic = 1947 ).
  ENDMETHOD.

  METHOD error_cases.
    assert_error( im_roman = 'A' ). "Invalid character
    assert_error( im_roman = 'ABC' ). "Invalid characters
    assert_error( im_roman = 'IIII' ). "more than 3
    assert_error( im_roman = 'MCXXXXI' ). "more than 3 inside
    assert_error( im_roman = 'MIC' ). "I only before X or V
  ENDMETHOD.

  METHOD clear_setup.
    CLEAR cut.
  ENDMETHOD.

ENDCLASS.
