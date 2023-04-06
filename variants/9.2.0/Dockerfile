FROM ruby:3.2-alpine3.17

# Install imap-backup
RUN gem install imap-backup -v 9.2.0

# Make the data directory a volume
VOLUME ["/root/.imap-backup"]

CMD [ "imap-backup" ]