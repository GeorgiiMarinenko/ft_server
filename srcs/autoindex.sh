#!/bin/bash

ON_OFF=$1

if [[ "$ON_OFF" == "on" || "$ON_OFF" == "off" ]];
then
	sed -i -E "/autoindex/ s/on|off/$ON_OFF/" /etc/nginx/sites-available/nginx.conf
	echo "autoindex has set to $ON_OFF"
	nginx -s reload
else
	echo "U shoud enter 'on' or 'off'"
fi
