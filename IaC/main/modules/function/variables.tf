variable "location" {
  description = "location of resources"
  type        = string
}

variable "resource-group" {
  description = "name of resource group"
  type        = string
}

variable "storage-ac-name" {
  description = "name of designated function storage"
  type        = string

}

variable "storage-ac-access_key" {
  description = "access key to designated function storage"
  type        = string
}

## ENV variables for function proper work

variable "ocr-storage-connection-string" {
  description = ""
  type = string
}

variable "ocr-file-share-name" {
  description = ""
  type = string
}

variable "ocr-blob-container-name" {
  description = ""
  type = string
}

variable "form-recognizer-endpoint" {
  description = ""
  type = string
}

variable "form-recognizer-api-key" {
  description = ""
  type = string
}