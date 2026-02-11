terraform {
  required_version = ">=1.0.0, <2.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.88.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.59.0"
    }
  }
}

provider "azurerm" {
  features {}
}