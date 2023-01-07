CLASS zcl_money_machine_howard DEFINITION   "EUR Notes and coins
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF money,
        coin TYPE string VALUE 'coin',
        note TYPE string VALUE 'note',
      END OF money,

      BEGIN OF notes,
        n_500 TYPE i VALUE 500,
        n_200 TYPE i VALUE 200,
        n_100 TYPE i VALUE 100,
        n_50  TYPE i VALUE 50,
        n_20  TYPE i VALUE 20,
        n_10  TYPE i VALUE 10,
        n_5   TYPE i VALUE 5,
      END OF notes,

      BEGIN OF coins,
        c_2 TYPE i VALUE 2,
        c_1 TYPE i VALUE 1,
      END OF coins,

      BEGIN OF error_value,
        c_type   TYPE string VALUE 'ERROR',
        c_amount TYPE i VALUE -1,
      END OF error_value.

    TYPES:
      BEGIN OF ty_change,
        amount TYPE i,
        type   TYPE string,
      END OF ty_change.

    TYPES:
*      tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY.
      tt_change TYPE SORTED TABLE OF ty_change WITH NON-UNIQUE KEY amount type.

    METHODS:
      get_amount_in_coins
        IMPORTING
          i_amount             TYPE i
        RETURNING
          VALUE(r_coin_amount) TYPE i,
      get_amount_in_notes
        IMPORTING
          i_amount             TYPE i
        RETURNING
          VALUE(r_note_amount) TYPE i,
      get_change
        IMPORTING
          i_amount        TYPE i
        RETURNING
          VALUE(r_change) TYPE tt_change.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: change TYPE i.
    METHODS:
      compute_change
        IMPORTING
          i_input         TYPE ty_change
        RETURNING
          VALUE(r_change) TYPE ty_change.
ENDCLASS.



CLASS zcl_money_machine_howard IMPLEMENTATION.

  METHOD get_amount_in_coins.
    r_coin_amount = COND #( WHEN i_amount <= 0
                      THEN -1
                      ELSE i_amount MOD 5 ).
  ENDMETHOD.


  METHOD get_amount_in_notes.
    r_note_amount = i_amount - get_amount_in_coins( i_amount ).
  ENDMETHOD.

  METHOD get_change.

    DATA: change_details TYPE ty_change.
    change = i_amount.

    IF change < 0.
      INSERT VALUE #( amount = error_value-c_amount type = error_value-c_type ) INTO TABLE r_change.
      RETURN.
    ELSEIF change = 0.
      RETURN.
    ELSE.
      WHILE change <> 0.

        "notes
        change_details = compute_change( i_input  = VALUE #( type = money-note amount = notes-n_500 ) ).
        IF change_details IS NOT INITIAL.
          INSERT change_details INTO TABLE r_change.
        ENDIF.

        change_details = compute_change( i_input  = VALUE #( type = money-note amount = notes-n_200 ) ).
        IF change_details IS NOT INITIAL.
          INSERT change_details INTO TABLE r_change.
        ENDIF.

        change_details = compute_change( i_input  = VALUE #( type = money-note amount = notes-n_100 ) ).
        IF change_details IS NOT INITIAL.
          INSERT change_details INTO TABLE r_change.
        ENDIF.

        change_details = compute_change( i_input  = VALUE #( type = money-note amount = notes-n_50 ) ).
        IF change_details IS NOT INITIAL.
          INSERT change_details INTO TABLE r_change.
        ENDIF.

        change_details = compute_change( i_input  = VALUE #( type = money-note amount = notes-n_20 ) ).
        IF change_details IS NOT INITIAL.
          INSERT change_details INTO TABLE r_change.
        ENDIF.

        change_details = compute_change( i_input  = VALUE #( type = money-note amount = notes-n_10 ) ).
        IF change_details IS NOT INITIAL.
          INSERT change_details INTO TABLE r_change.
        ENDIF.

        change_details = compute_change( i_input  = VALUE #( type = money-note amount = notes-n_5 ) ).
        IF change_details IS NOT INITIAL.
          INSERT change_details INTO TABLE r_change.
        ENDIF.

*      IF change MOD notes-n_20 <> change AND change MOD notes-n_20 < change.
*        INSERT VALUE ty_change( type = money-note amount = notes-n_20 ) INTO TABLE r_change.
*        change = change - notes-n_20.
*      ENDIF.
*
*      IF change MOD notes-n_10 <> change AND change MOD notes-n_10 < change.
*        INSERT VALUE ty_change( type = money-note amount = notes-n_10 ) INTO TABLE r_change.
*        change = change - notes-n_10.
*      ENDIF.
*
*      IF change MOD notes-n_5 <> change AND change MOD notes-n_5 < change.
*        INSERT VALUE ty_change( type = money-note amount = notes-n_5 ) INTO TABLE r_change.
*        change = change - notes-n_5.
*      ENDIF.

        IF change <= 5.

*        DO 2 TIMES.
*          IF change MOD coins-c_2 <> change AND change MOD coins-c_2 < change.
*            INSERT VALUE ty_change( type = money-coin amount = coins-c_2 ) INTO TABLE r_change.
*            change = change - coins-c_2.
*          ENDIF.
          change_details = compute_change( i_input  = VALUE #( type = money-coin amount = coins-c_2 ) ).
          IF change_details IS NOT INITIAL.
            INSERT change_details INTO TABLE r_change.
          ENDIF.
*        ENDDO.

          change_details = compute_change( i_input  = VALUE #( type = money-coin amount = coins-c_1 ) ).
          IF change_details IS NOT INITIAL.
            INSERT change_details INTO TABLE r_change.
          ENDIF.
*        IF change MOD coins-c_1 <> change AND change MOD coins-c_1 < change.
*          INSERT VALUE ty_change( type = money-coin amount = coins-c_1 ) INTO TABLE r_change.
*          change = change - coins-c_1.
*        ENDIF.
        ENDIF.

        DATA(stopper) = abap_false.
        IF stopper = abap_true.
          RETURN.
        ENDIF.
      ENDWHILE.
    ENDIF.
  ENDMETHOD.

  METHOD compute_change.
    IF change MOD i_input-amount <> change AND change MOD i_input-amount < change.
      change = change - i_input-amount.
      r_change = VALUE #( type = i_input-type amount = i_input-amount ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
