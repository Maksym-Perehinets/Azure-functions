locals {
  naming-location = lower(replace(var.location, " ", ""))
}

resource "random_id" "storage-account-suffix" {
  byte_length = 1
}

resource "azurerm_storage_account" "main" {
  name                     = "staocr${terraform.workspace}${local.naming-location}${random_id.storage-account-suffix.hex}"
  resource_group_name      = var.resource-group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = terraform.workspace == "prod" ? "GRS" : "LRS"

}

resource "azurerm_storage_account" "function-storage" {
  name                     = "stafunc${terraform.workspace}${local.naming-location}${random_id.storage-account-suffix.hex}"
  resource_group_name      = var.resource-group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = terraform.workspace == "prod" ? "GRS" : "LRS"

}

resource "azurerm_storage_container" "main" {
  name                  = "stc-ocr-${terraform.workspace}-${local.naming-location}"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}


resource "azurerm_storage_share" "main" {
  name                 = "stsh-ocr-${terraform.workspace}-${local.naming-location}"
  storage_account_name = azurerm_storage_account.main.name
  quota                = var.file-share-quota
}

