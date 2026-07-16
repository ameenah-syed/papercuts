[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
$required = @(
    'README.md',
    'AGENTS.md',
    'CONTRIBUTING.md',
    'docs/quick-triage.md',
    'docs/instructions-and-paths.md',
    'docs/runtimes-and-dependencies.md',
    'docs/windows-sandbox-and-filesystem.md',
    'docs/network-auth-and-tls.md',
    'docs/evidence-and-escalation.md',
    'docs/l1-dependency-sweeper.md',
    'scripts/diagnose-environment.ps1'
)

$missing = $required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $root $_)) }
if ($missing) {
    $missing | ForEach-Object { Write-Error "Missing required file: $_" }
    exit 1
}

$trackedText = Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object { $_.Extension -in '.md','.ps1','.html' }

$profilePattern = '[A-Za-z]:\\Users\\[^\\\s]+\\'
$fixture = 'C:' + '\Users\' + 'Example\private.txt'
if ($fixture -notmatch $profilePattern) {
    Write-Error 'Profile-path detector failed its synthetic fixture.'
    exit 1
}

$unsafe = $trackedText | Select-String -Pattern $profilePattern
if ($unsafe) {
    $unsafe | ForEach-Object { Write-Error "Machine-local profile path: $($_.Path):$($_.LineNumber)" }
    exit 1
}

Write-Output "Repository verification passed: $($required.Count) required files present; generic profile-path detector passed its fixture and found no machine-local profile paths."
