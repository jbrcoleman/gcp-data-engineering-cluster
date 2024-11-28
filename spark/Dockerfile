# Use an official Spark runtime as a parent image
FROM apache/spark-py:v3.4.0

USER root

# Set working directory
WORKDIR /app

# Copy the processing script and any additional requirements
COPY processing.py requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip3 install --upgrade pip --user
RUN pip3 install -r requirements.txt --user

# Download GCS connector
RUN wget https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-hadoop3-latest.jar -O /opt/spark/jars/gcs-connector.jar

# Set environment variables
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin

# Command to run the Spark job
CMD ["spark-submit", \
     "--master", "k8s://https://kubernetes.default.svc", \
     "--deploy-mode", "cluster", \
     "--conf", "spark.kubernetes.container.image=us-central1-docker.pkg.dev/tribal-flux-435217-i0/prject/spark", \
     "--conf", "spark.kubernetes.authenticate.driver.serviceAccountName=spark-sa", \
     "--conf", "spark.kubernetes.file.upload.path=gs://nyc-taxi-data-bucket-tribal-flux-435217-i0/spark-uploads/", \
     "processing.py"]