resource "google_compute_network" "vpc_network" {
  name                    = "nyc-taxi-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "nyc-taxi-subnet"
  ip_cidr_range = "10.2.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}