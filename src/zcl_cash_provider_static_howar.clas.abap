CLASS zcl_cash_provider_static_howar DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_change,
        amount TYPE i,
        type   TYPE string,
      END OF ty_change.
    TYPES tt_change TYPE SORTED TABLE OF ty_change WITH NON-UNIQUE KEY amount type .

    CLASS-METHODS:
      get_coins
        IMPORTING i_currency      TYPE string
        RETURNING VALUE(r_change) TYPE tt_change,
      get_notes
        IMPORTING i_currency      TYPE string
        RETURNING VALUE(r_change) TYPE tt_change.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_cash_provider_static_howar IMPLEMENTATION.
  METHOD get_coins.
    "Not usable for DOC testing
    ASSERT 0 = 1.
  ENDMETHOD.

  METHOD get_notes.
    "Not usable for DOC testing
    ASSERT 0 = 1.
  ENDMETHOD.

ENDCLASS.
