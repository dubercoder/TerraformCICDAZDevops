variable "rgname" {
}

variable "location" {
}

variable "datafactory_name" {
  default = "datafactoryiac"
  description = "Nombre del Datafactory"
}

variable "databricks_name" {
  default = "databricksiac2"
  description = "Nombre del Databricks"
}

variable "skuprocessdata" {
  default = "standard"
  description = "Sku databricks"
}
