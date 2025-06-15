variable "resource_group_name" {
    description = "GA first resource group"
    type = string
    default = "github-action-tff"
  
}

variable "location" {
    type = string
    default = "eastus"
  
}


variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}




variable "storage1" {
 type = string
 default = "githubstorage123"
  
}

variable "container" {
type = string
default = "storage-container"
  
}




