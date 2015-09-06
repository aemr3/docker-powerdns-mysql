FROM ubuntu

MAINTAINER Emre <e@emre.pm>

EXPOSE 53/udp 53/tcp

RUN apt-get update -q -q && DEBIAN_FRONTEND=noninteractive apt-get install pdns-server pdns-backend-mysql --yes --force-yes

RUN rm -rf /etc/powerdns/pdns.d/*

ADD run.sh /

CMD ["/run.sh"]
