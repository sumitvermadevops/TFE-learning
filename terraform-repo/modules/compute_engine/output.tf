output "instance_id" {
  value = google_compute_instance.default.id
}

output "self_link" {
  value = google_compute_instance.default.self_link
}

output "internal_ip" {
  value = google_compute_instance.default.network_interface[0].network_ip
}

output "external_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}