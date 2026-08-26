terraform {
  required_version = ">= 1.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "1c866f1b-0a68-496d-846a-e15a22199fb1"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-demo"
  location = "Central India"
}
