CLASS zcl_cash_provider_injector_how DEFINITION
  PUBLIC
  FINAL FOR TESTING
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      inject_cash_provider
        IMPORTING
          cash_provider TYPE REF TO zif_cash_provider_howard.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cash_provider_injector_how IMPLEMENTATION.
  METHOD inject_cash_provider.
    zcl_cash_provider_factory_how=>cash_provider = cash_provider.
  ENDMETHOD.

ENDCLASS.
