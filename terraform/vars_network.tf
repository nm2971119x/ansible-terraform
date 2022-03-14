variable "master_ip_intranet" {
  type = string
  description = "IP K8S Master"
  default = "10.0.1.10"
}

variable "node1_ip_intranet" {
  type = string
  description = "IP K8S Worker"
  default = "10.0.1.11"
}

variable "nfs_ip_intranet" {
  type = string
  description = "IP NFS Server"
  default = "10.0.1.12"
}
