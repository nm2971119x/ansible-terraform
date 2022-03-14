variable "vm_size_1core" {
  type = string
  description = "VM D1_v2 - 1 cpu - 3.5 gb RAM"
  default = "Standard_D1_v2"
}

variable "vm_size_2cores" {
  type = string
  description = "VM D2_v2 - 2 cpu - 7 gb RAM"
  default = "Standard_D2_v2"
}

variable "vms-nodes" {
 type = list(string)
 description = "VMs Nodos NFS / Workers" 
 default = ["node1","nfs"]
}