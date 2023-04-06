@"
# docker-imap-backup

[![github-actions](https://github.com/theohbrothers/docker-imap-backup/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-imap-backup/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-imap-backup?style=flat-square)](https://github.com/theohbrothers/docker-imap-backup/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-imap-backup/latest)](https://hub.docker.com/r/theohbrothers/docker-imap-backup)

Dockerized [imap-backup](https://github.com/joeyates/imap-backup).

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

## Usage

``````sh
# Print command line usage
docker run --rm -it theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) help

# Interactive setup
docker run --rm -it -v imap:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) setup

# Backup
docker run --rm -it -v imap:/root/.imap-backup theohbrothers/docker-imap-backup:$( $VARIANTS | ? { $_['tag_as_latest'] } | % { $_['tag'] } ) backup
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
