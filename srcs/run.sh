#!/bin/bash
service nginx start
# service php7.3-fpm start

# Configure a wordpress database
service mysql start
cd ../../..
mariadb < ./tmp/db_setup

bash
