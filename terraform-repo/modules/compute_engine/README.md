# GCE Instance Module

Reusable, production-ready GCE VM instance module with support for dynamic environment inference, metadata, disks, IP configuration, and service account.

## Usage

```hcl
variable "project_config" {
  default = {
    dev = {
      region                = "us-central1"
      zone                  = "us-central1-a"
      project               = "my-dev-project"
      network               = "default"
      subnetwork            = "default"
      service_account_email = "dev-sa@my-dev-project.iam.gserviceaccount.com"
    },
    prod = {
      region                = "us-east1"
      zone                  = "us-east1-b"
      project               = "my-prod-project"
      network               = "vpc-prod"
      subnetwork            = "subnet-prod"
      service_account_email = "prod-sa@my-prod-project.iam.gserviceaccount.com"
    }
  }
}

module "gce" {
  source = "../modules/gce_instance"

  environment         = "dev"
  project_config      = var.project_config

  gce_instance_config = {
    name                 = "my-vm"
    machine_type         = "e2-medium"
    boot_disk_image      = "debian-cloud/debian-11"
    boot_disk_size_gb    = 20
    boot_disk_type       = "pd-balanced"
    enable_public_ip     = true
    nat_ip               = null
    tags                 = ["web"]
    labels               = { env = "dev" }
    attached_disks       = []
    metadata             = { startup-script = "#!/bin/bash\necho Hello" }
    scopes               = ["cloud-platform"]
    preemptible          = false
    automatic_restart    = true
    on_host_maintenance  = "MIGRATE"
    startup_script       = ""
  }
}
```
