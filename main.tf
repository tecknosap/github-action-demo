terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = var.subscription_id
  features {

  }
}


resource "azurerm_resource_group" "tf_rg" {
  
  name = var.resource_group_name
  location = var.location
}


resource "azurerm_storage_account" "str1" {
  name                     = var.storage1
  resource_group_name      =  azurerm_resource_group.tf_rg.name
  location                 = azurerm_resource_group.tf_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}



resource "azurerm_storage_container" "example" {
  name                  = var.container
  storage_account_id    = azurerm_storage_account.str1.id
  container_access_type = "private"
}
