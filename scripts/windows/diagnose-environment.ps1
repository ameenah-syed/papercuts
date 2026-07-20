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

$tokenIsElevated = $false
try {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    $tokenIsElevated = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
} catch {}

$configuredSandbox = $null
$configPath = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.codex\config.toml'
if (Test-Path -LiteralPath $configPath -PathType Leaf) {
    $inWindows = $false
    foreach ($line in (Get-Content -LiteralPath $configPath)) {
        if ($line -match '^\s*\[([^]]+)\]\s*$') {
            $inWindows = ($Matches[1] -eq 'windows')
            continue
        }
        if ($inWindows -and $line -match '^\s*sandbox\s*=\s*"(elevated|unelevated)"\s*$') {
            $configuredSandbox = $Matches[1]
            break
        }
    }
}
$sandboxLogPresent = Test-Path -LiteralPath (Join-Path ([Environment]::GetFolderPath('UserProfile')) '.codex\.sandbox\sandbox.log') -PathType Leaf

[pscustomobject]@{
    Timestamp = (Get-Date).ToString('o')
    PowerShell = $PSVersionTable.PSVersion.ToString()
    Repository = $resolvedRepository
    Tools = $tools
    EnvironmentVariablePresence = $environmentPresence
    Git = $gitState
    WindowsSandbox = [pscustomobject]@{
        ConfiguredMode = $configuredSandbox
        TokenIsElevated = $tokenIsElevated
        SandboxLogPresent = $sandboxLogPresent
        OneRootLaunchRecommended = $true
        ProtectedCredentialStoresInspected = $false
    }
    Warning = 'Output contains local paths and repository metadata. Review and redact before sharing.'
} | ConvertTo-Json -Depth 6
