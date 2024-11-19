#!/bin/bash

# Create GCS bucket for NYC Taxi data
gsutil mb gs://nyc-taxi-data-bucket

# Download NYC Taxi Trip Records
wget https://d37ci6vzurdy5k.cloudfront.net/trip-data/yellow_tripdata_2023-01.parquet

# Upload to Google Cloud Storage
gsutil cp yellow_tripdata_2023-01.parquet gs://nyc-taxi-data-bucket/

# Create BigQuery dataset
bq mk nyc_taxi_dataset

# Load data from GCS to BigQuery
bq load \
  --source_format=PARQUET \
  nyc_taxi_dataset.trips \
  gs://nyc-taxi-data-bucket/yellow_tripdata_2023-01.parquet