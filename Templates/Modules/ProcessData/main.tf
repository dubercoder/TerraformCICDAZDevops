data "azurerm_resource_group" "rgname" {
   name = var.rgname
}

resource "azurerm_databricks_workspace" "databrickstf" {
    name                = var.databricks_name
    resource_group_name = data.azurerm_resource_group.rgname.name
    location            = var.location
    sku                 = var.skuprocessdata
}


resource "azurerm_data_factory" "datafactorytf" {
  name                  = var.datafactory_name
  location              = var.location
  resource_group_name   = data.azurerm_resource_group.rgname.name
}