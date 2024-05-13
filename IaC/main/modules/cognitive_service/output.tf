output "ocr-form-recognizer-endpoint" {
  value = azurerm_cognitive_account.main.endpoint
  sensitive = true
}

output "ocr-form-recognizer-api-key" {
  value = azurerm_cognitive_account.main.primary_access_key
  sensitive = true
}