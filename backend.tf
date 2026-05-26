terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "tfstateprod123085"
    container_name       = "teraform"
    key                  = "prod.terraform.tfstate"
  }
}