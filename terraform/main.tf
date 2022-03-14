terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
  }
}

## Grupo de recursos unificado
resource "azurerm_resource_group" "rg" {
    name     =  "k8s_rg"
    location = var.location

    tags = {
        environment = "CP2"
    }

}

## Cuenta para el almacenamiento
resource "azurerm_storage_account" "stAccount" {
    name                     = "staccountcp2dsc" 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "CP2"
    }

}