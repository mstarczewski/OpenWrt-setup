#!/bin/sh

# add to cron: 55 5 * * * /usr/sbin/change_guest_wifi_key.sh
# chmod 755

NEW_KEY=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c14)	

uci set wireless.guest.key="$NEW_KEY"
uci commit wireless

wifi