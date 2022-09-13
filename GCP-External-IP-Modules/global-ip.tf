resource "google_compute_address" "ip_address" {
  count = 3
  name = "external-ip-${count.index}"
  #address_type = "EXTERNAL"
  #region = var.region
  #network = data.google_compute_network.network.id
  #depends_on = [google_compute_network.network]
}
