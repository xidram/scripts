#!/bin/bash

# run backup
DIR=`date +%y%m%d%H%M`
DEST=/mnt/themo/mongo_backup/$DIR
mkdir $DEST
mongodump -h 127.0.0.1 -d themo -o $DEST

# delete backups older than 30 days
find /mnt/themo/mongo_backup/* -type d -ctime +30 -exec rm -rf {} \;
