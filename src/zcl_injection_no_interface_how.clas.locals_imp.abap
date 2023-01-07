*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

INTERFACE lif_cash_provider_howard.

  METHODS get_notes
    IMPORTING i_currency      TYPE string
    RETURNING VALUE(r_change) TYPE zcl_injection_no_interface_how=>tt_change.
ENDINTERFACE.

CLASS lcl_cash_provider_howard DEFINITION.
  PUBLIC SECTION.
  INTERFACES:
    lif_cash_provider_howard.

ENDCLASS.

CLASS lcl_cash_provider_howard IMPLEMENTATION.

  METHOD lif_cash_provider_howard~get_notes.
    r_change = zcl_cash_provider_static_howar=>get_coins( i_currency ).
  ENDMETHOD.

ENDCLASS.
