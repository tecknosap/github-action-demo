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
  features {
    
  }
}


resource "azurerm_resource_group" "tf_rg" {
  
  name = var.resource_group_name
  location = var.location
}