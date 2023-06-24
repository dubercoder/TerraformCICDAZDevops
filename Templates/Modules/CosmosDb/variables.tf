variable "rgname" {
}

variable "location" {
}
variable "throughput" {
  type        = number
  default     = 400
  description = "Cosmos db database throughput"
  validation {
    condition     = var.throughput >= 400 && var.throughput <= 1000000
    error_message = "Cosmos db manual throughput should be equal to or greater than 400 and less than or equal to 1000000."
  }
  validation {
    condition     = var.throughput % 100 == 0
    error_message = "Cosmos db throughput should be in increments of 100."
  }
}

variable "cosmos_db_names" {
  type    = list(string)
  default = ["cuno", "cdos", "ctres"]
}

variable "cosmos_db_containers" {
  type    = list(string)
  default = ["containeruno", "containerdos", "containertres"]
}

variable "sql_db_names" {
  type    = list(string)
  default = ["dbuno", "dbdos", "dbtres"]
}