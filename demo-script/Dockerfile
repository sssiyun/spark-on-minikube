# Use the official Apache Spark image as the base image
FROM bitnami/spark:latest

# Set environment variables
ENV SPARK_HOME=/opt/bitnami/spark
ENV PATH=$SPARK_HOME/bin:$PATH

# Create a directory for the Spark application
RUN mkdir -p /opt/spark-apps

# Copy your Spark script into the Docker image
COPY example.py /opt/spark-apps/

# Download the MySQL connector JAR and place it in the jars directory
RUN curl -o /opt/bitnami/spark/jars/mysql-connector-java-8.0.32.jar \
    https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar

# Set the entrypoint to use spark-submit
ENTRYPOINT ["/opt/bitnami/spark/bin/spark-submit"]

