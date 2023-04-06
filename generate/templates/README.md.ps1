@"
# docker-imap-backup

[![github-actions](https://github.com/theohbrothers/docker-imap-backup/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-imap-backup/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-imap-backup?style=flat-square)](https://github.com/theohbrothers/docker-imap-backup/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-imap-backup/latest)](https://hub.docker.com/r/theohbrothers/docker-imap-backup)

Dockerized [imap-backup](https://github.com/joeyates/imap-backup).

imap-backup syncs IMAP as ``.mbox`` backup files, in contrast to [isync](https://github.com/theohbrothers/docker-isync) which syncs IMAP as a ``Maildir`` (emails as individual files).

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
$(
($VARIANTS | % {
    if ( $_['tag_as_latest'] ) {
@"
| ``:$( $_['tag'] )``, ``:latest`` | [View](variants/$( $_['tag'] )) |

"@
    }else {
@"
| ``:$( $_['tag'] )`` | [View](variants/$( $_['tag'] )) |

"@
    }
}) -join ''
)

"@

@"
## Usage

See the following ``docker-compose`` examples:

- [Cron-based backup using ``crond``](docs/examples/cron)
- [Demo backup](docs/examples/demo)

``````sh
# Print command line usage
docker run --rm -it theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) help

# Interactive setup. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/setup.md
# 1. add account
#   1. email
#   2. password
#   3. server
#   4. connection options. For self-signed certs, use JSON: {"ssl": {"verify_mode": 0}}
#   5. test connection
#   13. Press (q) return to main menu
# 3. save and exit
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) setup

# View backup config
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) cat /root/.imap-backup/config.json

# Backup. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/backup.md
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) backup

# Check backup integrity (not available on <= 9.2.0)
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) local check

# Print backup stats
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) stats <email>

# List backup files. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/backup.md
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) ls -alR /root/.imap-backup

# Start a shell
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) sh
``````


"@

@'
## Development

Requires Windows `powershell` or [`pwsh`](https://github.com/PowerShell/PowerShell).

```powershell
# Install Generate-DockerImageVariants module: https://github.com/theohbrothers/Generate-DockerImageVariants
Install-Module -Name Generate-DockerImageVariants -Repository PSGallery -Scope CurrentUser -Force -Verbose

# Edit ./generate templates

# Generate the variants
Generate-DockerImageVariants .
```

'@
