variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which all resources will be created."
  type        = string
  default     = "storage-resource-group"
}