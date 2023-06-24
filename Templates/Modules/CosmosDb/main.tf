data "azurerm_resource_group" "rgname" {
   name = var.rgname
}


resource "azurerm_cosmosdb_account" "cosmos_uno" {
  count = length(var.cosmos_db_names)
  name = var.cosmos_db_names[count.index]
  location = var.location
  resource_group_name = data.azurerm_resource_group.rgname.name
  offer_type = "Standard"
  kind = "GlobalDocumentDB"
  enable_automatic_failover = false
   geo_location {
    location          = var.location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
}


resource "azurerm_cosmosdb_sql_database" "mainsql" {
  count               = length(var.sql_db_names)
  name                = var.sql_db_names[count.index]
  resource_group_name = data.azurerm_resource_group.rgname.name
  account_name        = var.cosmos_db_names[count.index]
  throughput          = var.throughput
  depends_on =        [azurerm_cosmosdb_account.cosmos_uno]
}

resource "azurerm_cosmosdb_sql_container" "examplecontainer" {
  count                 = length(var.cosmos_db_containers)
  name                  = var.sql_db_names[count.index]
  resource_group_name   = data.azurerm_resource_group.rgname.name
  account_name          = var.cosmos_db_names[count.index]
  database_name         = var.sql_db_names[count.index]
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  throughput            = var.throughput
  depends_on =        [azurerm_cosmosdb_account.cosmos_uno, azurerm_cosmosdb_sql_database.mainsql]

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }


    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}
