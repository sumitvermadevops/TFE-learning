variable "web_instance_number" {
  description = "Number of instances to create"
  default     = 1
}

variable "machine_type" {
  description = "The machine type to use for the instance"
  default     = "e2-micro"
}

variable "db_instance_number" {
  description = "Number of instances to create"
  default     = 1
}

variable "zone" {
  description = "The zone to create the instance in"
  default     = "us-west1-a"
}

variable "project_id" {
  description = "The project to create the instance in"
  default     = "gcplearn-362301"
}

variable "region" {
  description = "The region to create the instance in"
  default     = "us-west1"
}

variable "network" {
  description = "The network to create the instance in"
  default     = "twotier"
}

variable "websubnetwork" {
  description = "The subnetwork to create the instance in"
  default     = "webnetwork"
}

variable "dbsubnetwork" {
  description = "The subnetwork to create the instance in"
  default     = "dbnetwork"
}

variable "nat_ip" {
  description = "The nat ip to create the instance in"
  default     = ""
}

