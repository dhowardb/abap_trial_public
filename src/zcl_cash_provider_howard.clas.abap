CLASS zcl_cash_provider_howard DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_cash_provider_howard.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cash_provider_howard IMPLEMENTATION.
  METHOD zif_cash_provider_howard~get_coins.
    "Not usable for DOC testing
    ASSERT 0 = 1.
  ENDMETHOD.

  METHOD zif_cash_provider_howard~get_notes.
    "Not usable for DOC testing
    ASSERT 0 = 1.
  ENDMETHOD.

ENDCLASS.
