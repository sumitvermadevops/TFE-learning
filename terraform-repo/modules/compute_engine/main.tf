resource "google_compute_instance" "default" {
  name         = local.name
  machine_type = local.machine_type
  zone         = local.zone
  project      = local.project

  tags   = local.tags
  labels = local.labels

  boot_disk {
    initialize_params {
      image = local.boot_disk_image
      size  = local.boot_disk_size_gb
      type  = local.boot_disk_type
    }
  }

  network_interface {
    network    = local.network
    subnetwork = local.subnetwork

    dynamic "access_config" {
      for_each = local.enable_public_ip ? [1] : []
      content {
        nat_ip = local.nat_ip
      }
    }
  }

  dynamic "attached_disk" {
    for_each = local.attached_disks
    content {
      source      = attached_disk.value.source
      device_name = attached_disk.value.device_name
      mode        = attached_disk.value.mode
    }
  }

  metadata = local.metadata

  service_account {
    email  = local.service_account_email
    scopes = local.scopes
  }

  scheduling {
    preemptible         = local.preemptible
    automatic_restart   = local.automatic_restart
    on_host_maintenance = local.on_host_maintenance
  }

  metadata_startup_script = local.startup_script

  lifecycle {
    create_before_destroy = true
  }
}