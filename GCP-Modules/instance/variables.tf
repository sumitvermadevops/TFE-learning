variable "vm_name" {
  type        = string
  description = "The name of the instance."
  default     = ""
}

variable "machine_type" {
  type        = string
  description = "The machine type of the instance."
  default     = "e2-micro"
}

variable "image" {
  type        = string
  description = "The image of the instance."
  default     = "debian-cloud/debian-10"
}

variable "tags" {
  type        = list(string)
  description = "The tags of the instance."
  default     = ["http-server"]
}

variable "project_id" {
  type        = string
  description = "The ID of the project in which the resources will be provisioned."
  default     = "gcplearn-362301"
}

variable "region" {
  type        = string
  description = "The region in which the resources will be provisioned."
  default     = "us-west1"
}

variable "zone" {
  type        = string
  description = "The zone in which the resources will be provisioned."
  default     = "us-west1-a"
}

variable "network_name" {
  type        = string
  description = "The name of the network."
  default     = ""
}
variable "subnetwork_name" {
  type        = string
  description = "The name of the subnetwork."
  default     = ""
}
variable "subnetwork_cidr" {
  type        = string
  description = "The CIDR range of the subnetwork."
  default     = "10.0.0.0/24"
}

variable "subnetwork_project" {
  type        = string
  description = "The project ID of the subnetwork."
  default     = "gcplearn-362301"
}

variable "routing_mode" {
  type        = string
  description = "The routing mode of the network."
  default     = "GLOBAL"
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "Whether to create subnetworks automatically."
  default     = false
}