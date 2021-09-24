#!/usr/bin/env bash
#
while getopts d: flag
do
    case "${flag}" in
        d) domain=${OPTARG};;
    esac
done
file="/etc/nginx/sites-enabled/$domain.conf"
[ -e file ] && rm file
certbot delete --cert-name www.$domain
certbot delete --cert-name $domain