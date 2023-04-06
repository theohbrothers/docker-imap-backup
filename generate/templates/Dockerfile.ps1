@"
FROM ruby:3.2-alpine3.17

# Install imap-backup
RUN gem install imap-backup -v $( $VARIANT['_metadata']['package_version'] )

# Make the data directory a volume
VOLUME ["/root/.imap-backup"]

CMD [ "imap-backup" ]
"@
