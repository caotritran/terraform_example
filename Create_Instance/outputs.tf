output "PublicIP" {
  value = google_compute_instance.vm-test.network_interface[0].access_config[0]
}