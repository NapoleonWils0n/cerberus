#!/bin/bash


# docker export and import data into containers with tar files
#==============================================================


# backup www_withknown to tar file
docker run --volumes-from www_withknown -v $(pwd):/backup ubuntu tar cvf /backup/www_withknown_backup.tar /var/www

# backup mariadb_datastore to tar file
docker run --volumes-from mariadb_datastore -v $(pwd):/backup ubuntu tar cvf /backup/mariadb_datastore_backup.tar /var/lib/mysql


# scp mariadb_datastore_backup.tar to server
scp ~/Desktop/backup/mariadb_datastore_backup.tar root@192.168.1.3:/root/docker/mariadb_datastore_backup.tar

# scp www_withknown_backup.tar to server
scp ~/Desktop/backup/www_withknown_backup.tar root@192.168.1.3:/root/docker/www_withknown_backup.tar


# import tar file into container
docker run --volumes-from www_withknown -v $(pwd):/backup busybox tar xvf /backup/www_withknown_backup.tar

# import tar file into container
docker run --volumes-from mariadb_datastore -v $(pwd):/backup busybox tar xvf /backup/mariadb_datastore_backup.tar