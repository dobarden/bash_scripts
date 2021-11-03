#!/bin/bash

#Create a backup copy of data base
archive_db=DOMAIN_NAME-database-`date +%F`
mysqldump -u USER_NAME -p'USER_PASSWORD' DB_NAME | gzip > /PATH_TO_STORE_BACKUP/$archive_db.sql.gz

#Create a backup copy of site files
archive_files=DOMAIN_NAME-`date +%F`
/bin/tar -czvf /PATH_TO_STORE_BACKUP/$archive_files.tar.gz  /var/www/DOMAIN_NAME/

#Removing backups older than 7 days
sudo find /PATH_TO_STORE_BACKUP/ -type f -mtime +7 -exec rm -f {} \;
