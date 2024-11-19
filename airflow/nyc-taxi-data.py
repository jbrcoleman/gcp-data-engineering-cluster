rom airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    'nyc_taxi_data_pipeline',
    default_args=default_args,
    schedule_interval='@monthly',
    catchup=False
) as dag:
    
    # Task to load raw data from GCS to BigQuery
    load_raw_data = GCSToBigQueryOperator(
        task_id='load_raw_taxi_data',
        bucket='nyc-tlc-trip-records',
        source_objects=['yellow_tripdata_{{ macros.ds_format(ds, "%Y-%m", "%Y-%m") }}.parquet'],
        destination_project_dataset_table='nyc_taxi_data.raw_trips',
        source_format='PARQUET',
        write_disposition='WRITE_TRUNCATE'
    )

    # Task to transform and clean data
    transform_data = BigQueryInsertJobOperator(
        task_id='transform_taxi_data',
        configuration={
            'query': {
                'query': '''
                CREATE OR REPLACE TABLE `nyc_taxi_data.processed_trips` AS
                SELECT 
                    pickup_datetime,
                    dropoff_datetime,
                    passenger_count,
                    trip_distance,
                    total_amount,
                    payment_type
                FROM `nyc_taxi_data.raw_trips`
                WHERE trip_distance > 0 AND total_amount > 0
                ''',
                'useLegacySql': False
            }
        }
    )

    load_raw_data >> transform_data