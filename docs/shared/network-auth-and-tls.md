# Network, authentication, and TLS

Diagnose these as separate trust layers in this order:

1. Transport and proxy reachability
2. TLS certificate chain
3. Service authentication
4. Connector authorization
5. Elevated launcher policy

## Secret-safe presence checks

```powershell
'HTTP_PROXY','HTTPS_PROXY','ALL_PROXY','NO_PROXY','GH_TOKEN','GITHUB_TOKEN',
'SSL_CERT_FILE','REQUESTS_CA_BUNDLE','NODE_EXTRA_CA_CERTS','PIP_CERT','GIT_SSL_CAINFO' |
  ForEach-Object {
    [pscustomobject]@{
      Name  = $_
      IsSet = [bool][Environment]::GetEnvironmentVariable($_)
    }
  }
```

Do not enumerate all environment variables or print values.

## Transport

```powershell
Test-NetConnection github.com -Port 443 -InformationLevel Detailed
curl.exe --silent --show-error --fail --output NUL https://github.com/
$LASTEXITCODE
```

A refused proxy endpoint is a transport/configuration failure, not evidence of invalid GitHub credentials.

## TLS

An issuer-chain failure means the client cannot establish trust to an approved root. Verify system time and have the authorized administrator validate enterprise roots/intermediates. Never use `--insecure`, `-k`, `NODE_TLS_REJECT_UNAUTHORIZED=0`, or equivalent bypasses.

## GitHub authentication

```powershell
gh auth status --hostname github.com
```

Treat even sanitized auth status as operational metadata. Do not use `gh auth token` in diagnostics. If a stored credential is invalid, use GitHub CLI's supported interactive refresh/login in a trusted terminal after human approval. Repeated retries do not repair a revoked or expired credential.

## Connector authorization

Start read-only, scope access to selected repositories, record the owning identity and revocation path, and grant write access only for an explicitly approved operation.

Stop when repair requires credentials, trust-store changes, machine-wide proxy changes, broader connector scopes, package installation, or elevation.

