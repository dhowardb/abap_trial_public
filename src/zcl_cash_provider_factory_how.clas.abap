CLASS zcl_cash_provider_factory_how DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_cash_provider_injector_how.

  PUBLIC SECTION.
    CLASS-METHODS create
      RETURNING
        value(r_object) TYPE REF TO zif_cash_provider_howard.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      cash_provider TYPE REF TO zif_cash_provider_howard.
ENDCLASS.



CLASS zcl_cash_provider_factory_how IMPLEMENTATION.

  METHOD create.
    IF cash_provider IS NOT BOUND.
      cash_provider = NEW zcl_cash_provider__managed_how( ).
    ENDIF.
    r_object = cash_provider.
  ENDMETHOD.

ENDCLASS.
