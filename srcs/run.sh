#!/bin/bash
nginx -t
service nginx start

# Configure a wordpress database
service mysql start
cd ../../..
mariadb < ./tmp/db_setup

chown www-data:www-data var/www/*
chmod -R 755 /var/www/*

service php7.3-fpm start

bash
