FROM project42/s6-alpine:3.14
LABEL maintainer="Jake Wharton <docker@jakewharton.com>"

ENV \
    # Fail if cont-init scripts exit with non-zero code.
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    CRON="" \
    HEALTHCHECK_ID="" \
    HEALTHCHECK_HOST="https://hc-ping.com" \
    PUID="" \
    PGID="" \
    IMAP_PORT=993 \
    SSL_TYPE=IMAPS \
    SSL_VERSIONS=TLSv1.2

RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community > /etc/apk/repositories \
 && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
 && apk add --no-cache \
      isync@edge \
      curl@edge \
 && rm -rf /var/cache/* \
 && mkdir /var/cache/apk

COPY root/ /

