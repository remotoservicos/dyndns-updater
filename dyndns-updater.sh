#!/bin/bash
# Set Bash options to handle errors and unset variables rigorously
set -o errexit
set -o nounset
set -o pipefail

# DynDNS information
username=[Username]
updaterClientKey=[Updater Client Key]
domain=[Domain]

# Get the current public IP address
currentIp=$(curl -4 ipconfig.io)

# Resolve the domain to its current IP address
resolvedDomain=$(dig +short $domain @resolver1.opendns.com)

# Check if the resolved IP address of the domain matches the current IP address and request update, if necessary
if [[ "$resolvedDomain" != "$currentIp" ]]; then
    curl "https://"$username":"$updaterClientKey"@members.dyndns.org/v3/update?hostname="$domain"&myip="$currentIp""
fi
