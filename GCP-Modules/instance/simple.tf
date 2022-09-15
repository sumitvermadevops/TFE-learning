#Create GCP Instance
resource "google_compute_instance" "instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network            = var.network_name
    subnetwork         = var.subnetwork_name
    subnetwork_project = var.project_id
  }
  tags = var.tags
}

output "instance_name" {
  value = google_compute_instance.instance.name
}