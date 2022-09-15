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

variable "tags" {
  type        = list(string)
  description = "The tags of the instance."
  default     = ["http-server"]
}

variable "image" {
  type        = string
  description = "The image of the instance."
  default     = "debian-cloud/debian-10"
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

variable "num_instances" {
  type        = number
  description = "The number of instances to create."
  default     = 3
}

variable "machine_type" {
  type        = string
  description = "The machine type of the instance."
  default     = ""
}

