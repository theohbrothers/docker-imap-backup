# This script is to update versions in version.json, create PR(s) for each bumped version, merge PRs, and release
# It may be run manually or as a cron
# Use -WhatIf for dry run
[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(HelpMessage="Whether to clone a temporary repo before opening PRs. Useful in development")]
    [switch]$CloneTempRepo
,
    [Parameter(HelpMessage="Whether to open a PR for each updated version in version.json")]
    [switch]$PR
,
    [Parameter(HelpMessage="Whether to merge each PR one after another (note that this is not GitHub merge queue which cannot handle merge conflicts). The queue ensures each PR is rebased to prevent merge conflicts")]
    [switch]$AutoMergeQueue
,
    [Parameter(HelpMessage="Whether to create a tagged release and closing milestone, after merging all PRs")]
    [switch]$AutoRelease
,
    [Parameter(HelpMessage="-AutoRelease tag convention")]
    [ValidateSet('calver', 'semver')]
    [string]$AutoReleaseTagConvention = 'calver'
)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

# Install modules
@(
    'Generate-DockerImageVariantsHelpers'
    'Powershell-Yaml'
) | % {
    if (! (Get-InstalledModule $_ -ErrorAction SilentlyContinue) ) {
        Install-Module $_ -Scope CurrentUser -Force
    }
}
# Override with development module if it exists
if (Test-Path ../Generate-DockerImageVariantsHelpers/src/Generate-DockerImageVariantsHelpers) {
    Import-module ../Generate-DockerImageVariantsHelpers/src/Generate-DockerImageVariantsHelpers -Force
}

try {
    if ($CloneTempRepo) {
        $repo = Clone-TempRepo
        Push-Location $repo
    }

    # Get my versions from generate/definitions/versions.json
    $versions = Get-Content $PSScriptRoot/generate/definitions/versions.json -Encoding utf8 | ConvertFrom-Json
    # Get new versions
    $versionsNewExcluded = @(
        '10.0.0'    # Bad release. imap-backup 10.0.0 throws exception when being run. See: https://github.com/joeyates/imap-backup/releases/tag/v10.0.1
    )
    $versionsNew = (Invoke-WebRequest https://rubygems.org/api/v1/versions/imap-backup.json).Content | ConvertFrom-Json | % { $_.number } | ? { $_ -match '^\d+\.\d+\.\d+$' } | ? { $_ -notin $versionsNewExcluded }
    # Get changed versions
    $changeScope = 'patch'
    $versionsChanged = Get-VersionsChanged -Versions $versions -VersionsNew $versionsNew -ChangeScope $changeScope -AsObject -Descending
    # Update versions.json, and open PRs with CI disabled
    $prs = Update-DockerImageVariantsVersions -VersionsChanged $versionsChanged -CommitPreScriptblock { Move-Item .github .github.disabled -Force } -PR:$PR -WhatIf:$WhatIfPreference
    # Update versions.json, update PRs with CI, merge PRs one at a time, release and close milestone
    $return = Update-DockerImageVariantsVersions -VersionsChanged $versionsChanged -PR:$PR -AutoMergeQueue:$AutoMergeQueue -AutoRelease:$AutoRelease -AutoReleaseTagConvention $AutoReleaseTagConvention -WhatIf:$WhatIfPreference
}catch {
    throw
}finally {
    if ($CloneTempRepo) {
        Pop-Location
    }
}
