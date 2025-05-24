locals {
  project_settings        = var.project_config[var.environment]
  name                   = var.gce_instance_config.name
  machine_type           = var.gce_instance_config.machine_type
  zone                   = local.project_settings.zone
  project                = local.project_settings.project
  network                = local.project_settings.network
  subnetwork             = local.project_settings.subnetwork
  boot_disk_image        = var.gce_instance_config.boot_disk_image
  boot_disk_size_gb      = var.gce_instance_config.boot_disk_size_gb
  boot_disk_type         = var.gce_instance_config.boot_disk_type
  enable_public_ip       = var.gce_instance_config.enable_public_ip
  nat_ip                 = var.gce_instance_config.nat_ip
  tags                   = var.gce_instance_config.tags
  labels                 = var.gce_instance_config.labels
  attached_disks         = var.gce_instance_config.attached_disks
  metadata               = var.gce_instance_config.metadata
  service_account_email  = local.project_settings.service_account_email
  scopes                 = var.gce_instance_config.scopes
  preemptible            = var.gce_instance_config.preemptible
  automatic_restart      = var.gce_instance_config.automatic_restart
  on_host_maintenance    = var.gce_instance_config.on_host_maintenance
  startup_script         = var.gce_instance_config.startup_script
}