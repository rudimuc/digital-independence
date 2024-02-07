FROM alpine:3.11
LABEL MAINTAINER "Rudi Häusler"

RUN apk add --no-cache minidlna curl

ENV FRIENDLY_NAME "Medienserver"
ENV TCP_PORT "8200"
ENV SERIAL "1234567890"

COPY minidlna.conf /etc/minidlna.conf
COPY start.sh /

HEALTHCHECK --interval=60s --timeout=15s \
            CMD curl --silent --fail localhost:8200 || exit 1

EXPOSE 8200/tcp 1900/udp

CMD /start.sh

