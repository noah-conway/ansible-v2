#!/bin/sh

printf '\n%*s\n' "$(tput cols)" '' | tr ' ' '#'

ip=$(ip -4 addr show scope global | awk '/inet/ {print $2}' | cut -d/ -f1)

echo "\nListing all installed podman containers for user $(whoami)\n"

podman ps --format '{{.Names}},{{.Ports}},{{.Image}},{{.Status}}' 2>/dev/null | \
grep -v '^WARN' | \
awk -F',' -v ip="$ip" '{
    match($2,/:[0-9]+/)
    port=substr($2,RSTART+1,RLENGTH-1)
    $2=ip ":" port
    print $1,$2,$3,$4
}' | column -t

printf '\n%*s\n' "$(tput cols)" '' | tr ' ' '#'
