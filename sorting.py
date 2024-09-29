from pyspark.sql import SparkSession
from pyspark.sql.functions import desc, asc

spark = SparkSession.builder.appName("sorting").getOrCreate()
spark.sparkContext.setLogLevel('OFF')
logger = spark._jvm.org.apache.log4j
logger.LogManager.getRootLogger().setLevel(logger.Level.OFF)
# Read data from HDFS
df = spark.read.csv("hdfs://main:9000/data/part3_caps.csv",
                    inferSchema=True, header=False).toDF("Year", "SerialNumber")
# Filter and sort the data
result = df.filter(df["Year"] <= 2023).orderBy(
    desc("Year"), asc("SerialNumber"))

# Show the result (or write it back to HDFS or another storage)
with open("./output.txt", 'wb') as f:
    for row in result.collect():
        f.write(str(row['Year']) + "," + row['SerialNumber'])
        f.write("\n")

spark.stop()
