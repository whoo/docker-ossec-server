#!/bin/bash


openssl genrsa -out /var/ossec/etc/sslmanager.key 4096
openssl req -new  -x509 -key  /var/ossec/etc/sslmanager.key -out /var/ossec/etc/sslmanager.cert -days 365 -subj /CN=${HOSTNAME}/

/var/ossec/bin/ossec-authd &
PID=$!

if [ -e /var/ossec/etc/process_list ] 
then
	ln -fs /var/ossec/etc/process_list /var/ossec/bin/.process_list
fi


/etc/init.d/ossec start

function ossec_shutdown(){
/var/ossec/bin/ossec-control stop;
#kill $PID
}

trap "ossec_shutdown; exit" SIGINT SIGTERM



while true
do
clear
/var/ossec/bin/agent_control -l
sleep 5
done
