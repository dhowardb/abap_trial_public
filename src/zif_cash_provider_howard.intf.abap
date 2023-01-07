INTERFACE zif_cash_provider_howard
  PUBLIC .
  TYPES:
    BEGIN OF ty_change,
      amount TYPE i,
      type   TYPE string,
    END OF ty_change.
*  TYPES tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY.
  TYPES tt_change TYPE SORTED TABLE OF ty_change WITH NON-UNIQUE KEY amount type .
  METHODS get_notes
    IMPORTING i_currency      TYPE string
    RETURNING VALUE(r_change) TYPE tt_change.
  METHODS get_coins
    IMPORTING i_currency      TYPE string
    RETURNING VALUE(r_change) TYPE tt_change.
ENDINTERFACE.
