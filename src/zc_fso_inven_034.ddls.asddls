@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Inventory'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_FSO_INVEN_034
  as projection on ZI_FSO_Inven_034
{
  key Uuid,
      InventoryId,
      ProductId,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      Quantity,
      @Consumption.valueHelpDefinition: [{ 
        entity: {
            name: 'I_UnitOfMeasure',
            element: 'UnitOfMeasure'
        }
       }]      
      QuantityUnit,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      
      @Consumption.valueHelpDefinition: [{ 
        entity: {
            name: 'I_Currency',
            element: 'Currency'
        }
       }]
      CurrencyCode,
      Remark,
      NotAvailable,
      CreateBy,
      CreateAt,
      LastChangeBy,
      LastChangeAt
}
