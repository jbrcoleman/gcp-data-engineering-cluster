resource "google_compute_network" "vpc_network" {
  name                    = "nyc-taxi-network"
  auto_create_subnetworks = true
}