FROM ruby:3.2-alpine3.17

RUN apk add --no-cache ca-certificates
RUN set -eux; \
    apk add --no-cache alpine-sdk; \
    gem install imap-backup -v 11.0.1; \
    apk del --no-cache alpine-sdk; \
    imap-backup help > /dev/null

WORKDIR /root
VOLUME /root/.imap-backup

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]