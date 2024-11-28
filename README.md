# NYC Taxi Data Engineering Project with Kubernetes and Terraform

## Overview
A scalable data engineering project demonstrating ETL pipeline deployment using Kubernetes, Terraform, and Google Cloud Platform.

## Project Architecture
- **Infrastructure**: Terraform for GKE cluster provisioning
- **Orchestration**: Apache Airflow 
- **Data Processing**: Apache Spark
- **Data Storage**: BigQuery
- **Containerization**: Docker
- **Deployment**: Kubernetes

## Prerequisites
- Google Cloud Platform account
- Terraform
- Docker
- kubectl
- gcloud CLI

## Setup Instructions

### 1. Infrastructure Provisioning
```bash
terraform init
terraform plan
terraform apply
```

### 2. Build Docker Image
```bash
docker build -t nyc-taxi-spark-processor:v1 .
docker push [YOUR_REGISTRY]/nyc-taxi-spark-processor:v1
```

### 3. Data Import
```bash
./data_import_script.sh
```

### 4. Deploy to Kubernetes
```bash
kubectl apply -f k8s-deployment.yaml
```

## Dataset
- NYC Taxi Trip Records
- Source: NYC Taxi & Limousine Commission
- Frequency: Monthly updates
- Format: Parquet

## Key Components
- Terraform GKE cluster configuration
- Airflow DAG for data pipeline
- Spark data processing job
- Kubernetes deployment manifest

## Data Transformation
- Hourly trip aggregations
- Average fare calculations
- Trip distance analysis

## Future Improvements
- Add more complex data transformations
- Implement real-time streaming
- Enhanced error handling
- Cost optimization strategies
- monitoring