variable "rgname" {}
variable "location" {}


## CREATE - Resource Group's

module "mod_01" {
  source = "./Modules/ResourceGroup"
  rgname = var.rgname
  location = var.location
}

## CREATE COSMOSDB
module "mod_02" {
  source = "./Modules/CosmosDb"
  rgname = var.rgname
  location = var.location
  depends_on = [module.mod_01]
}


## CREATE AZ FUNCTIONS
module "mod_03" {
  source = "./Modules/AZFunctions"
  rgname = var.rgname
  location = var.location
  depends_on = [module.mod_01]
}

## CREATE Storage Datalake
module "mod_04" {
  source = "./Modules/StorageDataLake"
  rgname = var.rgname
  location = var.location
  depends_on = [module.mod_01]
}


## CREATE Process Data Module
module "mod_05" {
  source = "./Modules/ProcessData"
  rgname = var.rgname
  location = var.location
  depends_on = [module.mod_01]
}