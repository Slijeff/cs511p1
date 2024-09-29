####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

FROM cs511p1-common

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################

COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

COPY sorting.py sorting.py
COPY part3_caps.csv part3_caps.csv

COPY ./setup-main.sh ./setup-main.sh
RUN /bin/bash setup-main.sh

COPY ./start-main.sh ./start-main.sh
CMD ["/bin/bash", "start-main.sh"]
