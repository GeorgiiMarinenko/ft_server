FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

RUN mkdir /var/www/server
# WorkDirectory
# WORKDIR /etc/nginx/sites-available/

# Copying config file nginx
COPY ./srcs/example.crt /etc/ssl/certs/
COPY ./srcs/example.key /etc/ssl/private/
COPY ./srcs/nginx.conf /etc/nginx/sites-available/nginx.conf
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled
# RUN rm -rf default

#MySQL
COPY ./srcs/db_setup /tmp
# PhpMyAdmin
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz
RUN rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
COPY ./srcs/config.inc.php phpmyadmin
RUN mv phpmyadmin /var/www/server

# Wordpress
WORKDIR /var/www/server
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
RUN rm -rf latest.tar.gz
COPY ./srcs/wp-config.php /var/www/server/wordpress

# copy & lounch bash script
COPY ./srcs/run.sh /tmp
ENTRYPOINT bash /tmp/run.sh
