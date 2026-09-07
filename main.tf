terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dev" {
  name     = "rg-dev-terraform"
  location = "East US"

  tags = {
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}
