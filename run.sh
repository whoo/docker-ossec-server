#!/bin/sh

/var/ossec/bin/ossec-authd &
/etc/init.d/ossec start

while true
do
clear
/var/ossec/bin/agent_control -l
sleep 5
done
