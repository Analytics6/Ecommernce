terraform {
  backend "azurerm" {
    resource_group_name  = "ecom-rg"
    storage_account_name = "ecomtfstate"
    container_name       = "tfstate"
    key                  = "ecommernce.tfstate"
  }
}
