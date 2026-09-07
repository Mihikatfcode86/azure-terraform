resource "azurerm_resource_group" "dev" {

name = "rg-dv-terraform"

location = "Eas US"
 
tags = {

Environment = "Dev"

ManagedBy = "Terraform"
}

}
