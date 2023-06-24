#Invocar al RG donde se desplegarán estos recursos

data "azurerm_resource_group" "rgname" {
  name = var.rgname
}

#Crear Storage Account para las funciones.

resource "azurerm_storage_account" "stfunctions" {
    name                    =  "stfunctionsdev2"
    resource_group_name     = data.azurerm_resource_group.rgname.name
    location                = var.location
    account_tier            = "Standard"
    account_replication_type= "LRS"
}


# Crear el App Insights 

resource "azurerm_application_insights" "app_insights" {
    name        =    var.app_insights_name
    location    =    var.location
    resource_group_name = data.azurerm_resource_group.rgname.name
    application_type    = "web"
}

# Crear el App Service Plan para las functions.

resource "azurerm_service_plan" "app_service_plan" {
    name                = var.app_service_plan_name
    resource_group_name = data.azurerm_resource_group.rgname.name
    location            = var.location
    sku_name            = "P1v2"
    os_type             = "Linux"
}


# Crear las AZ Functions con un bucle.

resource "azurerm_linux_function_app" "AZ_Fucntions" {
  count               = length(var.az_functions_names)
  name                = var.az_functions_names[count.index]
  resource_group_name = data.azurerm_resource_group.rgname.name
  location            = var.location
  storage_account_name = azurerm_storage_account.stfunctions.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  site_config {}
  app_settings={
        APPLICATIONINSIGHTS_CONNECTION_STRING    = azurerm_application_insights.app_insights.connection_string
        APPINSIGHTS_INSTRUMENTATIONKEY           = azurerm_application_insights.app_insights.instrumentation_key
        AzureWebJobsStorage                      = azurerm_storage_account.stfunctions.primary_connection_string
        WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = azurerm_storage_account.stfunctions.primary_connection_string
        FUNCTIONS_EXTENSION_VERSION              = "~4"
        FUNCTIONS_WORKER_RUNTIME                 = "python"
    }
}