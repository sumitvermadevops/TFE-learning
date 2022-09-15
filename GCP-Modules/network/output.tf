#Create output for network module
output "network_name" {
  value = google_compute_network.network.self_link
}

output "subnetwork_name" {
  value = google_compute_subnetwork.subnetwork.self_link
}

output "subnetwork_cidr" {
  value = google_compute_subnetwork.subnetwork.ip_cidr_range
}