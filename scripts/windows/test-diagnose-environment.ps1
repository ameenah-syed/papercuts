$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$diagnostic = Join-Path $PSScriptRoot 'diagnose-environment.ps1'
$temporaryRoot = Join-Path ([IO.Path]::GetTempPath()) ('papercut-diagnostic-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $temporaryRoot -Force | Out-Null
try {
    git -C $temporaryRoot init -q
    $hosts = @((Get-Command powershell.exe -CommandType Application | Select-Object -First 1).Path)
    $core = Get-Command pwsh -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($core) { $hosts += $core.Path }
    foreach ($hostPath in $hosts) {
        $json = & $hostPath -NoProfile -File $diagnostic -RepositoryPath $temporaryRoot
        if ($LASTEXITCODE -ne 0) { throw "Diagnostic failed with $hostPath." }
        $result = ($json -join [Environment]::NewLine) | ConvertFrom-Json
        if ($result.Git.TopLevel -notmatch 'papercut-diagnostic-') { throw 'Synthetic Git root was not reported.' }
        if (-not $result.WindowsSandbox.OneRootLaunchRecommended) { throw 'One-root guidance is missing.' }
        if ($result.WindowsSandbox.ProtectedCredentialStoresInspected) { throw 'Diagnostic claims protected-store inspection.' }
        if ($null -ne $result.WindowsSandbox.ConfiguredMode -and
            $result.WindowsSandbox.ConfiguredMode -notin @('elevated','unelevated')) {
            throw 'Unexpected sandbox mode classification.'
        }
        Write-Output "Environment diagnostic test passed with $hostPath."
    }
}
finally {
    Remove-Item -LiteralPath $temporaryRoot -Recurse -Force -ErrorAction SilentlyContinue
}
