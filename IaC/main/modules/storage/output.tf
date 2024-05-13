output "function-storage-ac-name" {
  value = azurerm_storage_account.function-storage.name
}

output "function-storage-ac-access-key" {
  value = azurerm_storage_account.function-storage.primary_access_key
  sensitive = true
}

output "ocr-storage-ac-connection-string" {
  value = azurerm_storage_account.main.primary_connection_string
  sensitive = true
}

output "ocr-storage-ac-fileshare-name" {
  value = azurerm_storage_share.main.name
}

output "ocr-storage-ac-blob-name" {
  value = azurerm_storage_container.main.name
}