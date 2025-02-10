  features {}
}

resource "azurerm_resource_group" "test_joe" {
  name     = "test-joe-resources"
  location = "West Europe"
}

resource "azurerm_service_plan" "test_joe" {
  name                = "test-joe"
  resource_group_name = azurerm_resource_group.test_joe.name
  location            = azurerm_resource_group.test_joe.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "test_joe" {
  name                = "test-joe"
  resource_group_name = azurerm_resource_group.test_joe.name
  location            = azurerm_service_plan.test_joe.location
  service_plan_id     = azurerm_service_plan.test_joe.id

  site_config {}
}

