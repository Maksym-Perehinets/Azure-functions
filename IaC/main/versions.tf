terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }
  }

    backend "azurerm" {
      resource_group_name  = "ocr-remote-tf-back-end"
      storage_account_name = "remotetfbac324r4njrf"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }
}

provider "azurerm" {
  features {}
}

