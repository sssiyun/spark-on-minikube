# Base image
FROM ubuntu:20.04

# Set environment variables
# Please update the versions if necessary
# The download links might change, please refer to apache downloads page accordingly
ENV HADOOP_VERSION=3.4.0
ENV SPARK_VERSION=3.4.3
ENV HADOOP_HOME=/opt/hadoop
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget curl vim && \
    apt-get clean

# Install Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    tar -xzvf hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION $HADOOP_HOME && \
    rm hadoop-$HADOOP_VERSION.tar.gz

# Configure Hadoop
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# Install Spark
RUN wget https://downloads.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3.tgz && \
    tar -xzvf spark-$SPARK_VERSION-bin-hadoop3.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop3 $SPARK_HOME && \
    rm spark-$SPARK_VERSION-bin-hadoop3.tgz

# Copy Spark configuration files
COPY spark-defaults.conf $SPARK_HOME/conf/
COPY log4j.properties $SPARK_HOME/conf/

# Expose ports
EXPOSE 8080 7077 8081

# Set entrypoint
ENTRYPOINT ["/bin/bash"]
