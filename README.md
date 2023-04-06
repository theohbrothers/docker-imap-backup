# docker-imap-backup

[![github-actions](https://github.com/theohbrothers/docker-imap-backup/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-imap-backup/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-imap-backup?style=flat-square)](https://github.com/theohbrothers/docker-imap-backup/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-imap-backup/latest)](https://hub.docker.com/r/theohbrothers/docker-imap-backup)

Dockerized [imap-backup](https://github.com/joeyates/imap-backup).

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:9.2.0`, `:latest` | [View](variants/9.2.0) |

## Usage

For a simple backup demo, see [this](docs/examples/simple) docker-compose example.

```sh
# Print command line usage
docker run --rm -it theohbrothers/docker-imap-backup:9.2.0 help

# Interactive setup. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/setup.md
# 1. to add account
#   1. email
#   2. password
#   3. server
#   4. connection options. For self-signed certs, use JSON: {"ssl": {"verify_mode": 0}}
#   5. test connection
#   13. Press (q) return to main menu
# 3. save and exit
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:9.2.0 setup

# View backup config
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:9.2.0 cat /root/.imap-backup/config.json

# Backup. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/backup.md
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:9.2.0 backup

# Check backup integrity (not available on <= 9.2.0)
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:9.2.0 local check

# Print backup stats
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:9.2.0 stats <email>

# List backup files. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/backup.md
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:9.2.0 ls -alR /root/.imap-backup

# Start a shell
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:9.2.0 sh
```

## Development

Requires Windows `powershell` or [`pwsh`](https://github.com/PowerShell/PowerShell).

```powershell
# Install Generate-DockerImageVariants module: https://github.com/theohbrothers/Generate-DockerImageVariants
Install-Module -Name Generate-DockerImageVariants -Repository PSGallery -Scope CurrentUser -Force -Verbose

# Edit ./generate templates

# Generate the variants
Generate-DockerImageVariants .
```
