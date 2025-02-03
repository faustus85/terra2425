resource "azurerm_storage_account" "mcitstoragejoe" {
  name                     = "storageaccountjoe"
  resource_group_name      = azurerm_resource_group.mcitjoseph24.name
  location                 = azurerm_resource_group.mcitjoseph24.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
