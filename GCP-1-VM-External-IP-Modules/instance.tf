#Create google compute instance
resource "google_compute_instance" "instance" {
    count        = 3
    name         = "test-instance-${count.index}"
    machine_type = "e2-micro"
    zone         = "us-west1-a"
    

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