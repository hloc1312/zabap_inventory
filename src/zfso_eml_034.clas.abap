CLASS ZFSO_EML_034 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
        TY_T_IM TYPE TABLE FOR READ IMPORT ZI_FSO_Inven_034
       .
    INTERFACES IF_OO_ADT_CLASSRUN .

    METHODS: CREATE_INVENTORY.

    METHODS: UPDATE_INVENTORY_PRKEY.

    METHODS: UPDATE_INVENTORY_CID.

    METHODS: READ_INVENTORY IMPORTING VALUE(IM_INVENTORY) TYPE TY_T_IM.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      O TYPE REF TO IF_OO_ADT_CLASSRUN_OUT
     .
ENDCLASS.



CLASS ZFSO_EML_034 IMPLEMENTATION.


  METHOD IF_OO_ADT_CLASSRUN~MAIN.
    O = OUT.
    O->WRITE( 'Begin program' ).
    CREATE_INVENTORY(  ).
*    UPDATE_INVENTORY_PRKEY(  ).
*    UPDATE_INVENTORY_CID(  ).
  ENDMETHOD.


  METHOD CREATE_INVENTORY.
* Declare structure/itab
    DATA:
      LT_INVENTORY TYPE TABLE FOR CREATE ZI_FSO_Inven_034
     ,LS_INVENTORY TYPE STRUCTURE FOR CREATE ZI_FSO_Inven_034
     .
    O->WRITE( 'START METHOD CREATE INVENTORY' ).

    LS_INVENTORY = VALUE #( InventoryId  = 1005
                            CurrencyCode = 'USD'
                            ProductId    = 'Book'
                            Quantity     = 2
                            QuantityUnit = 'ea'
                            Price        = 98
                            Remark       = 'test create method' ).
    APPEND LS_INVENTORY TO LT_INVENTORY.

    LS_INVENTORY = VALUE #( InventoryId  = 1006
                            CurrencyCode = 'VND'
                            ProductId    = 'Ao'
                            Quantity     = 2
                            QuantityUnit = 'PC'
                            Price        = 98000
                            Remark       = 'test create method 1' ).
    APPEND LS_INVENTORY TO LT_INVENTORY.

* Call EML
    O->WRITE( 'CALL EML CREATE' ).

*   CREATE FIELDS ( ... ) WITH ITAB
    MODIFY ENTITIES OF ZI_FSO_Inven_034
                ENTITY Inventory
                CREATE
                FIELDS ( InventoryId
                         CurrencyCode
                         ProductId
                         Quantity
                         QuantityUnit
                         Price )
                  WITH LT_INVENTORY
                FAILED DATA(LS_FAIL)
              REPORTED DATA(LS_REPORTED)
                MAPPED DATA(LS_RESULT).

    IF LS_FAIL IS INITIAL.
      LOOP AT LS_RESULT-INVENTORY ASSIGNING FIELD-SYMBOL(<LFS_ITEM>).
        O->WRITE( |Key after creating: { <LFS_ITEM>-Uuid }| ).

        COMMIT ENTITIES.
      ENDLOOP.
      READ_INVENTORY( CORRESPONDING #( LS_RESULT-INVENTORY ) ).
    ELSE.
      O->WRITE( LS_REPORTED ).
    ENDIF.

    O->WRITE( 'END METHOD CREATE INVENTORY' ).

  ENDMETHOD.


  METHOD UPDATE_INVENTORY_PRKEY.
* Declare structure/itab
    DATA:
      LT_INVENTORY TYPE TABLE FOR UPDATE ZI_FSO_Inven_034
     ,LS_INVENTORY TYPE STRUCTURE FOR UPDATE ZI_FSO_Inven_034
     .
    O->WRITE( 'START METHOD UPDATE INVENTORY' ).
    LS_INVENTORY = VALUE #( Uuid     = '5EA15CF1129A1FD192F776428A1E57F7'
                            Remark   = 'hello ne'
                            Quantity = 1
*                            %CONTROL-Remark   = IF_ABAP_BEHV=>MK-ON
*                            %CONTROL-Quantity = IF_ABAP_BEHV=>MK-ON
                          ).
    APPEND LS_INVENTORY TO LT_INVENTORY.

* Call EML
    O->WRITE( 'Call EML Update' ).
    MODIFY ENTITIES OF ZI_FSO_Inven_034
                ENTITY Inventory
                UPDATE
                FIELDS ( Remark Quantity )
                  WITH LT_INVENTORY
                FAILED DATA(LS_FAIL)
              REPORTED DATA(LS_REPORT)
                MAPPED DATA(LS_RESULT).

    IF LS_FAIL IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      O->WRITE( LS_REPORT ).
    ENDIF.
    O->WRITE( 'END METHOD UPDATE INVENTORY' ).
  ENDMETHOD.


  METHOD UPDATE_INVENTORY_CID.
* Declare structure/itab
    DATA:
      LT_INVENTORY    TYPE TABLE FOR CREATE ZI_FSO_Inven_034
     ,LS_INVENTORY    TYPE STRUCTURE FOR CREATE ZI_FSO_Inven_034
     ,LT_INVENTORY_UP TYPE TABLE FOR UPDATE ZI_FSO_Inven_034
     ,LS_INVENTORY_UP TYPE STRUCTURE FOR UPDATE ZI_FSO_Inven_034
     .
    O->WRITE( 'START METHOD CREATE AND UPDATE INVENTORY' ).
* Set data for create
    LS_INVENTORY = VALUE #(
                            %CID                  = 'inv_1010'
                            InventoryId           = 1010
                            CurrencyCode          = 'USD'
                            ProductId             = 'Shirt'
                            Quantity              = 2
                            QuantityUnit          = 'EA'
                            Price                 = 98
                            Remark                = 'test create method'
                            %CONTROL-InventoryId  = IF_ABAP_BEHV=>MK-ON
                            %CONTROL-CurrencyCode = IF_ABAP_BEHV=>MK-ON
                            %CONTROL-ProductId    = IF_ABAP_BEHV=>MK-ON
                            %CONTROL-Quantity     = IF_ABAP_BEHV=>MK-ON
                            %CONTROL-QuantityUnit = IF_ABAP_BEHV=>MK-ON
                            %CONTROL-Price        = IF_ABAP_BEHV=>MK-ON
                            %CONTROL-Remark       = IF_ABAP_BEHV=>MK-ON ).

    APPEND LS_INVENTORY TO LT_INVENTORY.

* Set data for update
    LS_INVENTORY_UP = VALUE #(
                                %CID_REF          = 'inv_1010'
                                Quantity          = 100
                                Price             = 1200
                                Remark            = 'test update method'
                                %CONTROL-Quantity = IF_ABAP_BEHV=>MK-ON
                                %CONTROL-Price    = IF_ABAP_BEHV=>MK-ON
                                %CONTROL-Remark   = IF_ABAP_BEHV=>MK-ON ).
    APPEND LS_INVENTORY_UP TO LT_INVENTORY_UP.

* Call EML
    O->WRITE( 'Call EML Create and Update' ).
    MODIFY ENTITIES OF ZI_FSO_Inven_034
                ENTITY Inventory
                CREATE FROM LT_INVENTORY
                UPDATE FROM LT_INVENTORY_UP
                FAILED DATA(LS_FAIL)
              REPORTED DATA(LS_REPORT)
                MAPPED DATA(LS_RESULT).

    IF LS_FAIL IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      O->WRITE( LS_REPORT ).
    ENDIF.
    O->WRITE( 'END METHOD CREATE AND UPDATE INVENTORY' ).
  ENDMETHOD.


  METHOD READ_INVENTORY.
    READ ENTITIES OF ZI_FSO_Inven_034
    ENTITY Inventory
    ALL FIELDS WITH IM_INVENTORY
    RESULT DATA(LT_RESULT).

    LOOP AT LT_RESULT ASSIGNING FIELD-SYMBOL(<LFS_RESULT>).
      O->WRITE( <LFS_RESULT> ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
