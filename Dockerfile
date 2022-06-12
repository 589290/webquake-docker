ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/redhat/ubi/ubi8-minimal
ARG BASE_TAG=8.6

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

RUN microdnf -y update \
  && microdnf -y upgrade \
  && microdnf -y install httpd-2.4.37 tar gzip nodejs \
  && microdnf -y clean all

COPY wq.tar.gz /tmp
COPY entrypoint.sh /entrypoint.sh

RUN rm -rf /var/www/html \
  && cd /tmp \
  && mkdir /tmp/wq \
  && tar --strip 1 -xzvf wq.tar.gz -C /tmp/wq \
  && cd wq \
  && mv client /var/www/html \
  && mv server /opt \
  && cd /tmp \
  && rm -rf wq*

RUN  chown -R apache:apache /entrypoint.sh /opt/server /var/www/html /usr/share/httpd /var/log/httpd /etc/httpd \
  && chmod -R 775           /entrypoint.sh /opt/server /var/www/html /usr/share/httpd /var/log/httpd /etc/httpd \
  && printf '\n\nPidFile /tmp/httpd.pid' >> /etc/httpd/conf/httpd.conf

EXPOSE 80 26000

USER apache
ENV LANG=en_US.UTF-8
WORKDIR /opt/server
RUN npm install websocket

HEALTHCHECK --start-period=60s --retries=3 CMD curl --fail http://localhost:80 || exit 1

ENTRYPOINT ["/entrypoint.sh"]