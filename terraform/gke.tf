resource "google_container_cluster" "taxi_data_cluster" {
  name     = "nyc-taxi-data-cluster"
  location = "us-central1"

  # Enable Autopilot mode for simplified cluster management
  enable_autopilot = true

  # Networking configuration
  network = google_compute_network.vpc_network.name
  
  # Node pool configuration
  node_pool {
    initial_node_count = 3
    autoscaling {
      min_node_count = 1
      max_node_count = 5
    }
  }
}