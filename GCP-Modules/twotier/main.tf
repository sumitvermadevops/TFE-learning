resource "google_compute_address" "ip_address" {
  project = var.project_id
  region  = var.region
  count   = var.web_instance_number
  name    = "twotier-ip-${count.index}"
}

data "google_compute_network" "network" {
  name    = var.network
  project = var.project_id
}

data "google_compute_subnetwork" "websubnetwork" {
  name    = var.websubnetwork
  region  = var.region
  project = var.project_id
}

data "google_compute_subnetwork" "dbsubnetwork" {
  name    = var.dbsubnetwork
  region  = var.region
  project = var.project_id
}

#Create google frontend compute instance
resource "google_compute_instance" "web-server" {
  project = var.project_id
  #count        = var.web_instance_number
  count        = var.web_instance_number
  name         = "twotier-web-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["webserver", "websubnetwork", "twotier"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-bionic-v20191002"
    }
  }

  network_interface {
    network            = data.google_compute_network.network.name
    subnetwork         = data.google_compute_subnetwork.websubnetwork.name
    subnetwork_project = var.project_id

    access_config {
      nat_ip       = google_compute_address.ip_address[count.index].address
      network_tier = "PREMIUM"
    }
  }
  depends_on = [google_compute_address.ip_address, google_compute_instance.db-server]
}


#Create backend db instance
resource "google_compute_instance" "db-server" {
  project = var.project_id
  count   = var.db_instance_number
  name    = "twotier-db-${count.index}"

  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-bionic-v20191002"
    }
  }

  network_interface {
    network            = data.google_compute_network.network.name
    subnetwork         = data.google_compute_subnetwork.dbsubnetwork.name
    subnetwork_project = var.project_id
  }
}
output "webinstance_name" {
  value = google_compute_instance.web-server.*.name
}

output "dbinstance_name" {
  value = google_compute_instance.db-server.*.name
}

output "ip_address" {
  value = google_compute_address.ip_address.*.address
}

output "instance_machine_type" {
  value = google_compute_instance.web-server.*.machine_type
}