resource "google_container_cluster" "taxi_data_cluster" {
  name     = "nyc-taxi-data-cluster"
  location = "us-central1"

  # Enable Autopilot mode for simplified cluster management
  enable_autopilot = true
  
}