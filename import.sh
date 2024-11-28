#!/bin/bash

# Create GCS bucket for NYC Taxi data
gsutil mb gs://nyc-taxi-data-bucket-tribal-flux-435217-i0

# Download NYC Taxi Trip Records
wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet

# Upload to Google Cloud Storage
gsutil cp yellow_tripdata_2024-01.parquet gs://nyc-taxi-data-bucket-tribal-flux-435217-i0/

# Create BigQuery dataset
bq mk nyc_taxi_dataset

# Load data from GCS to BigQuery
bq load \
  --source_format=PARQUET \
  nyc_taxi_dataset.trips \
  gs://nyc-taxi-data-bucket-tribal-flux-435217-i0/yellow_tripdata_2024-01.parquet