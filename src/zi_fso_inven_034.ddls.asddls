@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Root View Inventory'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_FSO_Inven_034
  as select from zfso_inven_034
{
  key uuid           as Uuid,
      inventory_id   as InventoryId,
      product_id     as ProductId,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      quantity       as Quantity,
      quantity_unit  as QuantityUnit,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,
      currency_code  as CurrencyCode,
      remark         as Remark,
      not_available  as NotAvailable,

      @Semantics.user.createdBy: true
      create_by      as CreateBy,
      @Semantics.systemDateTime.createdAt: true
      create_at      as CreateAt,
      @Semantics.user.lastChangedBy: true
      last_change_by as LastChangeBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_change_at as LastChangeAt
}
