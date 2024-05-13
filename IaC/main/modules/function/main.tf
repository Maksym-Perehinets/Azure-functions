locals {
  naming-location = lower(replace(var.location, " ", ""))
}

resource "azurerm_application_insights" "main" {
  name                = "apinsght-ocrfunc-${terraform.workspace}-${local.naming-location}"
  location            = var.location
  resource_group_name = var.resource-group
  application_type    = "web"
}

resource "azurerm_service_plan" "main" {
  name                = "servpl-ocr-${terraform.workspace}-${local.naming-location}"
  resource_group_name = var.resource-group
  location            = var.location
  os_type             = "Linux"
  sku_name            = terraform.workspace == "prod" ? "EP1": "Y1"
}

resource "azurerm_linux_function_app" "main" {
  name                = "func-ocr-${terraform.workspace}-${local.naming-location}"
  resource_group_name = var.resource-group
  location            = var.location

  storage_account_name       = var.storage-ac-name
  storage_account_access_key = var.storage-ac-access_key
  service_plan_id            = azurerm_service_plan.main.id

  site_config {
    application_insights_connection_string = azurerm_application_insights.main.connection_string
    application_insights_key = azurerm_application_insights.main.instrumentation_key

    application_stack {
      python_version = "3.11"
    }
  }

  # ENV variables
  app_settings = {
    "STORAGE_CONNECTION_STRING" = var.ocr-storage-connection-string
    "FILE_SHARE_NAME" = var.ocr-file-share-name
    "BLOB_CONTAINER_NAME" = var.ocr-blob-container-name
    "FORM_RECOGNIZER_ENDPOINT" = var.form-recognizer-endpoint
    "FORM_RECOGNIZER_API_KEY" = var.form-recognizer-api-key
  }

}