To leverage the twotier module, call this module from main.tf file as shown below:

/*#Terrafor provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.35.0"
    }
  }
}

module "twotier" {
  source = "../modules/test/twotier"

}*/