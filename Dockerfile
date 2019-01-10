FROM ubuntu:18.04

RUN apt-get update && apt-get install stubby net-tools dnsutils -y

COPY stubby.yml /etc/stubby/stubby.yml

VOLUME /etc/stubby

EXPOSE 53/udp

ENTRYPOINT ["stubby"]
