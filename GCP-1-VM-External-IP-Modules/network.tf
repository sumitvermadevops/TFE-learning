#Create google compute network
resource "google_compute_network" "network" {
    name                    = var.network_name
    auto_create_subnetworks = false
    #depends_on              = [data.google_compute_network.network]
}

data "google_compute_network" "network" {
    name = google_compute_network.network.name
}

output "network" {
    value = data.google_compute_network.network.id
}