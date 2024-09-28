#!/bin/bash

####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

# Exchange SSH keys.
/etc/init.d/ssh start
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/shared_rsa
ssh-copy-id -i ~/.ssh/id_rsa -o 'IdentityFile ~/.ssh/shared_rsa' -o StrictHostKeyChecking=no -f worker1
ssh-copy-id -i ~/.ssh/id_rsa -o 'IdentityFile ~/.ssh/shared_rsa' -o StrictHostKeyChecking=no -f worker2

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################

# Start HDFS/Spark main here
# Format and start the HDFS Namenode
hdfs namenode -format
hdfs namenode &

# Start the HDFS DataNode service
hdfs datanode &

bash
