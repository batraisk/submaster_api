#!/usr/bin/env bash
#
while getopts d:u: flag
do
    case "${flag}" in
        d) domain=${OPTARG};;
        u) username=${OPTARG};;
    esac
done

# Functions
ok() { echo -e '\e[32m'$domain'\e[m'; } # Green
die() { echo -e '\e[1;31m'$domain'\e[m'; exit 1; }

# Variables
NGINX_AVAILABLE_VHOSTS='/etc/nginx/sites-enabled'
# NGINX_ENABLED_VHOSTS='/etc/nginx/sites-enabled'
WEB_DIR='/home'
WEB_USER=$username

# Sanity check
[ $(id -g) != "0" ] && die "Script must be run as root."
#[ $# != "1" ] && die "Usage: $(basename $0) domainName"

# Create nginx config file
cat > $NGINX_AVAILABLE_VHOSTS/$domain.conf <<EOF

server {
  server_name $domain www.$domain;
  root /home/deploy/submaster_api/current/public;

  passenger_enabled on;
    passenger_app_env production;

  location ~ ^.+\..+$ {
    try_files \$uri =404;
  }

  client_max_body_size 100m;
}

server {
  server_name $domain www.$domain;
    listen 80;
    return 404; # managed by Certbot

}
EOF

#ln -s /etc/nginx/sites-enabled/$domain.conf /etc/nginx/sites-available/$domain.conf
# Changing permissions
chown -R $WEB_USER:$WEB_USER $WEB_DIR/$username

# Enable site by creating symbolic link
# ln -s $NGINX_AVAILABLE_VHOSTS/$1 $NGINX_ENABLED_VHOSTS/$1
sudo certbot --nginx -n --agree-tos -m batraisk@gmail.com -d www.$domain
service nginx restart
ok "Site Created for $domain"