#Invocar al RG donde se desplegarán estos recursos.data "data "" "name" {
  
data "azurerm_resource_group" "rgname" {
   name = var.rgname
}


#Crear el Storage Account para el Datalake.

resource "azurerm_storage_account" "stdatalake" {
    name                    = var.st_datalake_name
    resource_group_name     = data.azurerm_resource_group.rgname.name
    location                = var.location
    account_tier            = "Standard"
    account_replication_type= "LRS"
    is_hns_enabled          = true
}

resource "azurerm_storage_data_lake_gen2_filesystem" "filesystemdatalake" {
  name                    = "datalakefilesystem"
  storage_account_id      = azurerm_storage_account.stdatalake.id
}