resource "azurerm_storage_account" "mcitstoragejoe" {
  name                     = "storageaccountjoe"
  resource_group_name      = resource "azurerm_resource_group" "mcitjoseph24" {
  location                 = azurerm_resource_group.mcitjoseph24.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
