# Use an official Spark runtime as a parent image
FROM apache/spark-py:v3.4.0

# Set working directory
WORKDIR /app

# Copy the processing script and any additional requirements
COPY nyc_taxi_processing.py requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin

# Command to run the Spark job
CMD ["spark-submit", \
     "--master", "k8s://https://kubernetes.default.svc", \
     "--deploy-mode", "cluster", \
     "--conf", "spark.kubernetes.container.image=nyc-taxi-spark-processor:v1", \
     "--conf", "spark.kubernetes.authenticate.driver.serviceAccountName=spark-sa", \
     "nyc_taxi_processing.py"]