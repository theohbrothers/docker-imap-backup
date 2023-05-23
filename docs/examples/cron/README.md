# Cron-based example

## Usage

Start the container:

```sh
docker-compose up
```

At entrypoint:

- A crontab is created that runs `imap-backup` daily at `00:00`
- `crond` is started

Now, setup `imap-backup` for each email account you want to backup, e.g. `your@domain.com`:

```sh
# Interactive setup. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/setup.md
# 1. add account
#   1. email
#   2. password
#   3. server
#   4. connection options. For self-signed certs, use JSON: {"ssl": {"verify_mode": 0}}
#   5. test connection
#   13. Press (q) return to main menu
# 3. save and exit
docker-compose exec imap-backup imap-backup setup
```

To run the first-time backup:

```sh
docker-compose exec imap-backup imap-backup backup
```

Now, wait out for `00:00` of tomorrow.

At `00:00`, your incremental backup would have run very quickly.

Print backup stats:

```sh
docker-compose exec imap-backup imap-backup stats your@domain.com
```

List backup files:

```sh
docker-compose exec imap-backup ls -alR /root/.imap-backup
```

Start a shell:

```sh
docker-compose exec imap-backup sh
```
