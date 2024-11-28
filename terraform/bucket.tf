# Create a Google Cloud Storage bucket
resource "google_storage_bucket" "bucket" {
  name          = "nyc-taxi-data-bucket-tribal-flux-435217-i0"
  location      = "US"
  force_destroy = true  # Optional: allows Terraform to delete bucket with contents

  # Optional: Configure bucket versioning
  versioning {
    enabled = true
  }


  uniform_bucket_level_access = true

  labels = {
    environment = "development"
    project     = "ny-taxi-data"
  }
}