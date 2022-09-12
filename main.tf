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

#Create google compute network
resource "google_compute_network" "network" {
    name                    = var.network_name
    auto_create_subnetworks = false
}

#Create google compute subnetwork
resource "google_compute_subnetwork" "subnetwork" {
    project       = var.project_id
    depends_on    = [google_compute_network.network]
    name          = var.subnetwork_name
    ip_cidr_range = var.cidr_range
    region        = var.region
    network       = google_compute_network.network.id
}

resource "google_compute_address" "ip_address" {
    name = "external-ip"
    #address_type = "EXTERNAL"
    #region = var.region
    #network = data.google_compute_network.network.id
    #depends_on = [google_compute_network.network]
}

#Fetch network and subnetwork details
data "google_compute_network" "network" {
    name = google_compute_network.network.name
}
data "google_compute_subnetwork" "subnetwork" {
    name = google_compute_subnetwork.subnetwork.name

}
data "google_compute_address" "ip_address" {
    name = google_compute_address.ip_address.name
    depends_on = [google_compute_instance.instance]
}

#Create google compute instance
resource "google_compute_instance" "instance" {
    name         = "test-instance"
    machine_type = "e2-micro"
    zone         = "us-west1-a"

    boot_disk {
        initialize_params {
        image = "ubuntu-os-cloud/ubuntu-1804-bionic-v20191002"
        }
    }

    network_interface {
        network = data.google_compute_network.network.name
        subnetwork = data.google_compute_subnetwork.subnetwork.name
            access_config {
            nat_ip = google_compute_address.ip_address.address
            network_tier = "PREMIUM"
            }
        }
    depends_on = [google_compute_subnetwork.subnetwork]
}

output "network_name" {
    value = google_compute_network.network.name
}

output "subnetwork_name" {
    value = google_compute_subnetwork.subnetwork.name
}

output "instance_name" {
    value = google_compute_instance.instance.name
}

output "instance_ip" {
    value = google_compute_instance.instance.network_interface[0].network_ip
}

output "instance_external_ip" {
    value = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
}