#!/bin/bash
service nginx start
# service php7.3-fpm start

# Configure a wordpress database
service mysql start
cd ../../..
mariadb < ./tmp/db_setup

chown www-data:www-data var/www/*

service php7.3-fpm start

bash
