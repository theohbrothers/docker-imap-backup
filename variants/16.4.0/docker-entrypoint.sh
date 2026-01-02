#!/bin/sh
set -eu

if [ $# -gt 0 ]; then
    SUBCOMMANDS=$( imap-backup help | grep -E '^\s*imap-backup' | awk '{print $2}' | sort -n | uniq )
    if echo "$SUBCOMMANDS" | grep "^$1$" > /dev/null; then
        exec imap-backup "$@"
    fi
fi

exec "$@"
