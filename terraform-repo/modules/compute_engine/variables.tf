variable "environment" {
  description = "Static environment identifier (e.g. dev, prod)"
  type        = string
}

variable "project_config" {
  description = "Predefined environment config map"
  type = map(object({
    region               = string
    zone                 = string
    project              = string
    network              = string
    subnetwork           = string
    service_account_email = string
  }))
}

variable "gce_instance_config" {
  type = object({
    name                 = string
    machine_type         = string
    boot_disk_image      = string
    boot_disk_size_gb    = number
    boot_disk_type       = string
    enable_public_ip     = bool
    nat_ip               = string
    tags                 = list(string)
    labels               = map(string)
    attached_disks       = list(object({
      source      = string
      device_name = string
      mode        = string
    }))
    metadata             = map(string)
    scopes               = list(string)
    preemptible          = bool
    automatic_restart    = bool
    on_host_maintenance  = string
    startup_script       = string
  })
}