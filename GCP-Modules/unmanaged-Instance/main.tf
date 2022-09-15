#Terrafor provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.35.0"
    }
  }
}

#call network module
module "network" {
  source       = "../modules/test/network"
  network_name = "sumit-network"
}

module "umig" {
  source = "../modules/test/u-mig"

  network_name    = module.network.network_name
  subnetwork_name = module.network.subnetwork_name
}