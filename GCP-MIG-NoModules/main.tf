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

#Fetch network and subnetwork details
data "google_compute_network" "network" {
    name = google_compute_network.network.name
}
data "google_compute_subnetwork" "subnetwork" {
    name = google_compute_subnetwork.subnetwork.name

}

resource "google_compute_address" "ip_address" {
    count = 3
    name = "external-ip-${count.index}"
}
#data "google_compute_address" "ip_address" {
#    name = google_compute_address.ip_address.name
#    depends_on = [google_compute_instance.instance]
#}



#Create google compute instance
resource "google_compute_instance" "instance" {
    count        = 3
    name         = "terraform-vm-${count.index}"
    machine_type = "e2-micro"
    zone         = var.zone
    

boot_disk {
    initialize_params {
    image = "ubuntu-os-cloud/ubuntu-1804-bionic-v20191002"
    }
}

network_interface {
    network    = data.google_compute_network.network.name
    subnetwork = data.google_compute_subnetwork.subnetwork.name
    access_config {
    nat_ip       = element(google_compute_address.ip_address.*.address, count.index)    
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
value = google_compute_instance.instance.*.name
}

output "External_IP" {
    value = google_compute_instance.instance[*].network_interface.0.access_config.0.nat_ip
}

output "Private_IP" {
    value = google_compute_instance.instance[*].network_interface.0.network_ip
    }

#Create Managed Instance Template for GCP
resource "google_compute_instance_template" "instance_template" {
name_prefix  = "terraform-mig-1"
machine_type = "e2-micro"
#zone        = var.zone
tags         = ["http-server", "https-server"]
can_ip_forward       = false

#Delays creation of instance template until network and subnetwork are created
depends_on = [google_compute_network.network, google_compute_subnetwork.subnetwork]

scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
}

#Create a new boot disk from an image
    disk {
        source_image      = "debian-cloud/debian-11"
        auto_delete       = true
        boot              = true
}
    network_interface {
        network    = var.network_name
        subnetwork = var.subnetwork_name
    }
}

output "instance_template" {
value = google_compute_instance_template.instance_template.id
}

#Create Managed Instance Group for GCP
resource "google_compute_instance_group" "instance_group" {
name = "terraform-mig-1"
zone = var.zone

depends_on = [google_compute_instance.instance.0, google_compute_instance.instance.1, google_compute_instance.instance.2]
instances = [google_compute_instance.instance.0.self_link, google_compute_instance.instance.1.self_link, google_compute_instance.instance.2.self_link]
}

output "instance_group" {
value = google_compute_instance_group.instance_group.id
}

output "instance_group_instances" {
value = google_compute_instance_group.instance_group.instances
}


