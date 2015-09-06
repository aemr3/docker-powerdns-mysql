FROM ubuntu

MAINTAINER Emre <e@emre.pm>

EXPOSE 53/udp 53/tcp

RUN apt-get update -q -q && DEBIAN_FRONTEND=noninteractive apt-get install pdns-server pdns-backend-mysql --yes --force-yes

RUN apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/powerdns/pdns.d/*

COPY run.sh /run.sh

RUN chmod +x /run.sh

CMD ["/run.sh"]
