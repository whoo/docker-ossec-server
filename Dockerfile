FROM debian:jessie
RUN apt-key adv --fetch-keys http://ossec.wazuh.com/repos/apt/conf/ossec-key.gpg.key
RUN echo "deb http://ossec.wazuh.com/repos/apt/debian jessie main" >> /etc/apt/sources.list
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install ossec-hids openssl
COPY run.sh /
RUN cp -a /var/ossec/etc /var/ossec/etc.orig
RUN cp -a /var/ossec/logs /var/ossec/logs.orig
RUN touch /var/ossec/etc/process_list && ln /var/ossec/etc/process_list /var/ossec/bin/.process_list
ENTRYPOINT /run.sh
