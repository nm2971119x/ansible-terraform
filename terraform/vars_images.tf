variable "vm_image_urn" {
  type = string
  description = "URN de la imagen"
  default = "Canonical:0001-com-ubuntu-server-focal-daily:20_04-daily-lts:20.04.202203100"
}

variable "vm_image_publisher" {
  type = string
  description = "Publisher de la imagen"
  default = "Canonical"
}

variable "vm_image_offer" {
  type = string
  description = "Imagen de distribucion"
  default = "0001-com-ubuntu-server-focal-daily"
}

variable "vm_image_version" {
  type = string
  description = "Version de la imagen"
  default = "20.04.202203100"
}

variable "vm_image_sku" {
  type = string
  description = "SKU de la imagen"
  default = "20_04-daily-lts"
}