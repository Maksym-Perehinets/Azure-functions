locals {
  naming-location = lower(replace(var.location, " ", ""))
}

resource "azurerm_cognitive_account" "main" {
  name                = "docinteleg-ocr-${terraform.workspace}-${local.naming-location}"
  location            = var.location
  resource_group_name = var.resource-group
  kind                = "FormRecognizer"
  sku_name = terraform.workspace == "prod" ? "F0": "S0"
}