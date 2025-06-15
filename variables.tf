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

    type = string
    default = "319d26df-5744-44d2-ba82-01b31fa6c8cb"
  
}



variable "storage1" {
 type = string
 default = "githubstorage123"
  
}

variable "container" {
type = string
default = "storage-container"
  
}




