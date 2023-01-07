CLASS zcl_cash_provider__managed_how DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_cash_provider_factory_how.

  PUBLIC SECTION.
    INTERFACES:
      zif_cash_provider_howard.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cash_provider__managed_how IMPLEMENTATION.
  METHOD zif_cash_provider_howard~get_coins.
    "Not usable for DOC testing
    ASSERT 0 = 1.
  ENDMETHOD.

  METHOD zif_cash_provider_howard~get_notes.
    "Not usable for DOC testing
    ASSERT 0 = 1.
  ENDMETHOD.

ENDCLASS.
