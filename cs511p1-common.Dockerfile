####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

FROM openjdk:8

RUN apt update && \
    apt upgrade --yes && \
    apt install ssh openssh-server --yes

# Setup common SSH key.
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/shared_rsa -C common && \
    cat ~/.ssh/shared_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################

# Setup HDFS/Spark resources here
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

###### !!!COMMENT BELOW WHEN RUNNING REAL TESTS #####
COPY hadoop-3.3.6.tar.gz .
RUN  tar -xzf hadoop-3.3.6.tar.gz && \
    mv hadoop-3.3.6 /usr/local/hadoop && \
    rm hadoop-3.3.6.tar.gz
###### !!!COMMENT ABOVE WHEN RUNNING REAL TESTS #####

# RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
#     tar -xzf hadoop-3.3.6.tar.gz && \
#     mv hadoop-3.3.6 /usr/local/hadoop && \
#     rm hadoop-3.3.6.tar.gz

ENV HADOOP_VER=3.3.6
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
COPY core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
# COPY hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
