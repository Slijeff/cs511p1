docker-compose -f cs511p1-compose.yaml exec main bash -x -c "
hdfs dfs -mkdir -p /data && \
hdfs dfs -put -f part3_caps.csv /data/part3_caps.csv"

docker-compose -f cs511p1-compose.yaml exec main \
  spark-submit sorting.py > sorting_out.txt 2>&1

docker-compose -f cs511p1-compose.yaml exec main bash -c "cat output.txt"
