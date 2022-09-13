terraform {
    required_providers {
        google = {
        source  = "hashicorp/google"
        version = "4.35.0"
        }
    }
}

provider "google" {
    project = var.project_id
    region  = var.region
    zone    = var.zone
}

output "network_name" {
value = google_compute_network.network.name
}

output "subnetwork_name" {
value = google_compute_subnetwork.subnetwork.name
}

output "instance_name" {
value = google_compute_instance.instance.*.name
}

output "External_IP" {
    value = google_compute_instance.instance[*].network_interface.0.access_config.0.nat_ip
}

#Print instance IP
output "Private_IP" {
    value = google_compute_instance.instance[*].network_interface.0.network_ip
    }
