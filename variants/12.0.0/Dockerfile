FROM ruby:3.2-alpine3.17

RUN apk add --no-cache ca-certificates
RUN set -eux; \
    gem install imap-backup -v 12.0.0; \
    imap-backup help > /dev/null

WORKDIR /root
VOLUME /root/.imap-backup

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]