from pyspark.sql import SparkSession
import pandas as pd

mysql_host = "MYSQL_HOST"
mysql_port = "MYSQL_PORT"
mysql_user = "MYSQL_USER"
mysql_password = "MYSQL_PASSWORD"
mysql_db = "MYSQL_DB"
table = "MY_TABLE"

# JDBC URL and properties
jdbc_url = f"jdbc:mysql://{mysql_host}:{mysql_port}/{mysql_db}"
jdbc_properties = {
    "user": mysql_user,
    "password": mysql_password,
    "driver": "com.mysql.cj.jdbc.Driver",
}


def main():
    # Initialize Spark session
    spark = SparkSession.builder.appName("ExampleSQL").getOrCreate()

    # SQL query
    sql_query = f"SELECT * FROM {table} LIMIT 10"

    # Read data from SQL database
    df = spark.read.jdbc(
        url=jdbc_url, table=f"({sql_query}) as query", properties=jdbc_properties
    )

    # Show the data
    df.show()

    # Stop the Spark session
    spark.stop()


if __name__ == "__main__":
    main()
