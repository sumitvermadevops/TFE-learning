resource "google_compute_address" "ip_address" {
  project = var.project_id
  region  = var.region
  count   = var.num_instances
  name    = "external-ip-${count.index}"
}

#Create google compute instance
resource "google_compute_instance" "instance" {
  count        = var.num_instances
  name         = "terraform-vm-${count.index}"
  machine_type = "e2-micro"
  zone         = var.zone
  project      = var.project_id
  #region       = var.region


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-bionic-v20191002"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    access_config {
      nat_ip       = element(google_compute_address.ip_address.*.address, count.index)
      network_tier = "PREMIUM"
    }
  }

}

#Create Managed Instance Template for GCP
resource "google_compute_instance_template" "instance_template" {
  name_prefix    = "terraform-mig-1"
  machine_type   = "e2-micro"
  project        = var.project_id
  region         = var.region
  tags           = ["http-server", "https-server"]
  can_ip_forward = false

  #Delays creation of instance template until network and subnetwork are created
  #depends_on = [google_compute_network.network, google_compute_subnetwork.subnetwork]

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }

  #Create a new boot disk from an image
  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
  }
}

#Create Managed Instance Group for GCP
resource "google_compute_instance_group" "instance_group" {
  name    = "terraform-mig-1"
  zone    = var.zone
  project = var.project_id

  depends_on = [google_compute_instance.instance.0, google_compute_instance.instance.1, google_compute_instance.instance.2]
  instances  = [google_compute_instance.instance.0.self_link, google_compute_instance.instance.1.self_link, google_compute_instance.instance.2.self_link]
}