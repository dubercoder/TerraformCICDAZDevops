variable "rgname" {
}

variable "location" {
}

variable "app_insights_name" {
  default = "Functions-App-Insight"
  description = "Nombre del App Insight"
}

variable "app_service_plan_name" {
  default = "Functions-App-Service"
  description = "Nombre del App Service Plan"
}


variable "az_functions_names" {
  type    = list(string)
  default = ["func-data-uno", "func-data-dos", "func-data-tres"]
}