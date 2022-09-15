#Declare variables for network modules
variable "project_id" {
  type        = string
  description = "The ID of the project in which the resources will be provisioned."
  default     = ""
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
variable "environment" {
  type        = string
  description = "The environment in which the resources will be provisioned."
  default     = "dev"
}
variable "network_name" {
  type        = string
  description = "The name of the network."
  default     = "test-network"
}
variable "subnetwork_name" {
  type        = string
  description = "The name of the subnetwork."
  default     = "test-subnetwork"
}
variable "subnetwork_cidr" {
  type        = string
  description = "The CIDR range of the subnetwork."
  default     = "10.20.0.0/24"
}

variable "subnetwork_project" {
  type        = string
  description = "The project ID of the subnetwork."
  default     = ""
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
