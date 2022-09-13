#Create google compute subnetwork

resource "google_compute_subnetwork" "subnetwork" {
    project       = var.project_id
    depends_on    = [google_compute_network.network]
    name          = var.subnetwork_name
    ip_cidr_range = var.cidr_range
    region        = var.region
    network       = data.google_compute_network.network.name
}

data "google_compute_subnetwork" "subnetwork" {
    name          = google_compute_subnetwork.subnetwork.name
    #ip_cidr_range = var.cidr_range
    region        = google_compute_subnetwork.subnetwork.region
    #auto_create_subnetworks = false
    #description = "This will create the main VPC"
}


output "subnetwork" {
    value = data.google_compute_subnetwork.subnetwork.id
}