# docker-imap-backup

[![github-actions](https://github.com/theohbrothers/docker-imap-backup/actions/workflows/ci-master-pr.yml/badge.svg?branch=master)](https://github.com/theohbrothers/docker-imap-backup/actions/workflows/ci-master-pr.yml)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-imap-backup?style=flat-square)](https://github.com/theohbrothers/docker-imap-backup/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-imap-backup/latest)](https://hub.docker.com/r/theohbrothers/docker-imap-backup)

Dockerized [imap-backup](https://github.com/joeyates/imap-backup).

imap-backup syncs IMAP as `.mbox` backup files, in contrast to [isync](https://github.com/theohbrothers/docker-isync) which syncs IMAP as a `Maildir` (emails as individual files).

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:16.4.1`, `:latest` | [View](variants/16.4.1) |
| `:16.3.0` | [View](variants/16.3.0) |
| `:16.2.0` | [View](variants/16.2.0) |
| `:16.1.0` | [View](variants/16.1.0) |
| `:16.0.0` | [View](variants/16.0.0) |
| `:15.1.3` | [View](variants/15.1.3) |
| `:15.0.2` | [View](variants/15.0.2) |
| `:14.6.1` | [View](variants/14.6.1) |
| `:14.5.2` | [View](variants/14.5.2) |
| `:14.4.5` | [View](variants/14.4.5) |
| `:14.3.0` | [View](variants/14.3.0) |
| `:14.2.0` | [View](variants/14.2.0) |
| `:14.1.1` | [View](variants/14.1.1) |
| `:14.0.0` | [View](variants/14.0.0) |
| `:13.4.0` | [View](variants/13.4.0) |
| `:13.3.0` | [View](variants/13.3.0) |
| `:13.2.0` | [View](variants/13.2.0) |
| `:13.1.0` | [View](variants/13.1.0) |
| `:13.0.0` | [View](variants/13.0.0) |
| `:12.1.0` | [View](variants/12.1.0) |
| `:12.0.0` | [View](variants/12.0.0) |
| `:11.1.0` | [View](variants/11.1.0) |
| `:11.0.1` | [View](variants/11.0.1) |
| `:10.0.1` | [View](variants/10.0.1) |
| `:9.3.2` | [View](variants/9.3.2) |
| `:9.2.0` | [View](variants/9.2.0) |
| `:9.1.1` | [View](variants/9.1.1) |
| `:9.0.2` | [View](variants/9.0.2) |
| `:8.0.2` | [View](variants/8.0.2) |
| `:7.0.2` | [View](variants/7.0.2) |
| `:6.3.0` | [View](variants/6.3.0) |
| `:6.2.1` | [View](variants/6.2.1) |
| `:6.1.0` | [View](variants/6.1.0) |
| `:6.0.1` | [View](variants/6.0.1) |

## Usage

See the following `docker-compose` examples:

- [Cron-based backup using `crond`](docs/examples/cron)
- [Demo backup](docs/examples/demo)

```sh
# Print command line usage
docker run --rm -it theohbrothers/docker-imap-backup:16.4.1 help

# Interactive setup. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/setup.md
# 1. add account
#   1. email
#   2. password
#   3. server
#   4. connection options. For self-signed certs, use JSON: {"ssl": {"verify_mode": 0}}
#   5. test connection
#   13. Press (q) return to main menu
# 3. save and exit
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:16.4.1 setup

# View backup config
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:16.4.1 cat /root/.imap-backup/config.json

# Backup. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/backup.md
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:16.4.1 backup

# Check backup integrity (not available on <= 9.2.0)
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:16.4.1 local check

# Print backup stats
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:16.4.1 stats <email>

# List backup files. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/backup.md
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:16.4.1 ls -alR /root/.imap-backup

# Restore emails from backup to IMAP server. See: https://github.com/joeyates/imap-backup/blob/main/docs/commands/restore.md
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:9.3.1 restore <email>

# Start a shell
docker run --rm -it -v imap-backup:/root/.imap-backup theohbrothers/docker-imap-backup:16.4.1 sh
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

### Variant versions

[versions.json](generate/definitions/versions.json) contains a list of [Semver](https://semver.org/) versions, one per line.

To update versions in `versions.json`:

```powershell
./Update-Versions.ps1
```

To update versions in `versions.json`, and open a PR for each changed version, and merge successful PRs one after another (to prevent merge conflicts), and finally create a tagged release and close milestone:

```powershell
$env:GITHUB_TOKEN = 'xxx'
./Update-Versions.ps1 -PR -AutoMergeQueue -AutoRelease
```

To perform a dry run, use `-WhatIf`.
