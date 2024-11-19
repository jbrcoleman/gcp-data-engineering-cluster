from pyspark.sql import SparkSession
from pyspark.sql.functions import col, date_trunc, avg

def process_taxi_data(input_path, output_path):
    # Initialize Spark Session
    spark = SparkSession.builder \
        .appName("NYCTaxiDataProcessing") \
        .getOrCreate()

    # Read Parquet files
    df = spark.read.parquet(input_path)

    # Perform aggregations
    processed_df = df.groupBy(
        date_trunc("hour", col("pickup_datetime")).alias("pickup_hour")
    ).agg(
        avg("total_amount").alias("avg_fare"),
        avg("trip_distance").alias("avg_distance")
    )

    # Write processed data
    processed_df.write.parquet(output_path)

    spark.stop()

if __name__ == "__main__":
    process_taxi_data(
        input_path="gs://nyc-tlc-trip-records/yellow_tripdata_*.parquet",
        output_path="gs://nyc-taxi-processed-data/aggregated_trips/"
    )