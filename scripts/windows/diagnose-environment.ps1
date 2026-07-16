[CmdletBinding()]
param(
    [Parameter()]
    [string]$RepositoryPath = (Get-Location).Path
)

$ErrorActionPreference = 'Continue'

function Get-ResolvedCommand {
    param([string]$Name)
    $command = Get-Command $Name -ErrorAction SilentlyContinue | Select-Object -First 1
    [pscustomobject]@{
        Name = $Name
        Found = [bool]$command
        CommandType = if ($command) { [string]$command.CommandType } else { $null }
        Source = if ($command) { [string]$command.Source } else { $null }
    }
}

$resolvedRepository = $null
try {
    $resolvedRepository = (Resolve-Path -LiteralPath $RepositoryPath -ErrorAction Stop).Path
} catch {
    Write-Error "Repository path could not be resolved: $RepositoryPath"
    exit 2
}

$tools = 'git','python','py','pip','node','npm','npx','pnpm','corepack','gh','cl','msbuild','cmake','ninja' |
    ForEach-Object { Get-ResolvedCommand -Name $_ }

$presenceNames = @(
    'HTTP_PROXY','HTTPS_PROXY','ALL_PROXY','NO_PROXY','GH_TOKEN','GITHUB_TOKEN',
    'SSL_CERT_FILE','REQUESTS_CA_BUNDLE','NODE_EXTRA_CA_CERTS','PIP_CERT','GIT_SSL_CAINFO'
)
$environmentPresence = $presenceNames | ForEach-Object {
    [pscustomobject]@{
        Name = $_
        IsSet = [bool][Environment]::GetEnvironmentVariable($_)
    }
}

$git = Get-Command git -ErrorAction SilentlyContinue
$gitState = $null
if ($git) {
    $gitState = [pscustomobject]@{
        TopLevel = (& git -C $resolvedRepository rev-parse --show-toplevel 2>$null)
        Branch = (& git -C $resolvedRepository branch --show-current 2>$null)
        Status = @(& git -C $resolvedRepository status --short 2>$null)
        Worktrees = @(& git -C $resolvedRepository worktree list --porcelain 2>$null)
    }
}

[pscustomobject]@{
    Timestamp = (Get-Date).ToString('o')
    PowerShell = $PSVersionTable.PSVersion.ToString()
    Repository = $resolvedRepository
    Tools = $tools
    EnvironmentVariablePresence = $environmentPresence
    Git = $gitState
    Warning = 'Output contains local paths and repository metadata. Review and redact before sharing.'
} | ConvertTo-Json -Depth 6
