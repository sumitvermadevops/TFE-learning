#Create GCP network
resource "google_compute_network" "network" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  #region                  = var.region

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  lifecycle {
    ignore_changes = [
      routing_mode,
    ]
  }
}

data "google_compute_network" "network" {
  name    = var.network_name
  project = var.project_id
  #region  = var.region
}

resource "google_compute_subnetwork" "subnetwork" {
  project       = var.project_id
  depends_on    = [google_compute_network.network]
  name          = var.subnetwork_name
  ip_cidr_range = var.subnetwork_cidr
  network       = var.network_name
  region        = var.region
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork_name
  project = var.project_id

  #ip_cidr_range = var.cidr_range
  region = google_compute_subnetwork.subnetwork.region
  #auto_create_subnetworks = false
  #description = "This will create the main VPC"
}

#Create output for network module
/*output "network" {
  value = google_compute_network.network.self_link
}

output "subnetwork" {
  value = google_compute_subnetwork.subnetwork.self_link
}

output "cidr" {
  value = google_compute_subnetwork.subnetwork.ip_cidr_range
}*/