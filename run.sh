#!/bin/sh


openssl genrsa -out /var/ossec/etc/sslmanager.key 4096
openssl req -new  -x509 -key  /var/ossec/etc/sslmanager.key -out /var/ossec/etc/sslmanager.cert -days 365 -subj /CN=${HOSTNAME}/

/var/ossec/bin/ossec-authd &
/etc/init.d/ossec start

while true
do
clear
/var/ossec/bin/agent_control -l
sleep 5
done
