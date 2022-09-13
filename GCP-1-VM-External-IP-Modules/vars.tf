variable "project_id" {
  type    = string
  default = "gcplearn-362301"
}

variable "region" {
  type    = string
  default = "us-west1"
}

variable "zone" {
  type    = string
  default = "us-west1-a"
}

variable "vm_name" {
  type    = string
  default = "terraform-vm"
}

variable "network_name" {
  default = "sumit-network"

}

variable "auto_subnetwork" {
  default = "false"
}

variable "subnetwork_name" {
  default = "sumit-subnetwork"
}

variable "cidr_range" {
  default = "10.0.0.0/28"
}

variable "subnetwork_region" {
  default = "us-west1"
}