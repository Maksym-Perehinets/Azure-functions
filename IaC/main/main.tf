locals {
  naming-location = lower(replace(var.location, " ", ""))
}

resource "azurerm_resource_group" "dev" {
  name     = "rg-ocr-${terraform.workspace}-${local.naming-location}"
  location = var.location
}

module "storage" {
  source           = "./modules/storage"
  location         = var.location
  resource-group   = azurerm_resource_group.dev.name
  file-share-quota = terraform.workspace == "prod" ? 5 : 1
}

module "cognitive_service" {
  source         = "./modules/cognitive_service"
  location       = var.location
  resource-group = azurerm_resource_group.dev.name
}

module "function" {
  source = "./modules/function"
  depends_on = [
    module.cognitive_service,
    module.storage
  ]
  location       = var.location
  resource-group = azurerm_resource_group.dev.name

  # Designated function storage
  storage-ocr-ac-name          = module.storage.function-ocr-storage-ac-name
  storage-ocr-ac-access_key    = module.storage.function-ocr-storage-ac-access-key
  storage-notify-ac-name       = module.storage.function-notify-storage-ac-name
  storage-notify-ac-access_key = module.storage.function-notify-storage-ac-access-key

  # ENV variables
  ocr-storage-connection-string = module.storage.ocr-storage-ac-connection-string
  ocr-file-share-name           = module.storage.ocr-storage-ac-fileshare-name
  ocr-blob-container-name       = module.storage.ocr-storage-ac-blob-name
  form-recognizer-endpoint      = module.cognitive_service.ocr-form-recognizer-endpoint
  form-recognizer-api-key       = module.cognitive_service.ocr-form-recognizer-api-key
}