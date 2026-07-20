[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
$required = @(
    'README.md',
    'AGENTS.md',
    'CONTRIBUTING.md',
    'docs/shared/README.md',
    'docs/shared/quick-triage.md',
    'docs/shared/instructions-and-paths.md',
    'docs/shared/runtimes-and-dependencies.md',
    'docs/shared/network-auth-and-tls.md',
    'docs/shared/evidence-and-escalation.md',
    'docs/shared/l1-dependency-sweeper.md',
    'docs/shared/live-delivery-log.md',
    'docs/windows/README.md',
    'docs/windows/sandbox-and-filesystem.md',
    'docs/macos/README.md',
    'docs/linux/README.md',
    'scripts/windows/diagnose-environment.ps1',
    'scripts/windows/test-diagnose-environment.ps1'
)

$missing = $required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $root $_)) }
if ($missing) {
    $missing | ForEach-Object { Write-Error "Missing required file: $_" }
    exit 1
}

$trackedText = Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' -and $_.Extension -in '.md','.ps1','.html' }

$profilePattern = '[A-Za-z]:[\\/]+Users[\\/]+[^\\/\s]+[\\/]'
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

$skillPayloads = Get-ChildItem -LiteralPath $root -Recurse -Filter 'SKILL.md' -File
if ($skillPayloads) {
    $skillPayloads | ForEach-Object { Write-Error "Skill payload belongs in the private skills repository: $($_.FullName)" }
    exit 1
}

$implementationSurfaces = @(
    'scripts/windows/diagnose-environment.ps1',
    'scripts/windows/test-diagnose-environment.ps1'
)
$forbiddenPatterns = @(
    'Start-Process.+RunAs',
    'Invoke-Expression',
    'danger-full-access',
    'dangerously-bypass-approvals-and-sandbox',
    'Set-ItemProperty.+EnableLUA',
    'schtasks'
)
foreach ($surface in $implementationSurfaces) {
    $source = Get-Content -Raw -LiteralPath (Join-Path $root $surface)
    foreach ($pattern in $forbiddenPatterns) {
        if ($source -match $pattern) {
            Write-Error "Forbidden implementation surface: $surface $pattern"
            exit 1
        }
    }
}

Write-Output "Repository verification passed: $($required.Count) required files present; OS lanes present; no skill payloads or machine-local profile paths found."
