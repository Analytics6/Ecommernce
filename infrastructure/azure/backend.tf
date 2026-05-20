terraform {
  backend "azurerm" {
    resource_group_name  = "ecom-terraform-rg"
    storage_account_name = "ecomterraformstate"
    container_name       = "tfstate"
    key                  = "ecommernce.tfstate"
  }
}
