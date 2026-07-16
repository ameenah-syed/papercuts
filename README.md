# Codex Environment Papercuts

A dependency-free troubleshooting handbook for recurring Codex, Windows, path, runtime, package-manager, sandbox, network, and GitHub authentication failures.

The goal is classification before correction. Start with read-only evidence, identify the failing layer, permit at most one focused recovery, and escalate with a sanitized evidence packet when the recovery fails or requires additional authority.

## Start here

1. Read [Quick triage](docs/quick-triage.md).
2. Run the read-only [environment diagnostic](scripts/diagnose-environment.ps1) from PowerShell.
3. Open the guide for the classified failure:
   - [Instructions and paths](docs/instructions-and-paths.md)
   - [Runtimes and dependencies](docs/runtimes-and-dependencies.md)
   - [Windows sandbox and filesystem](docs/windows-sandbox-and-filesystem.md)
   - [Network, authentication, and TLS](docs/network-auth-and-tls.md)
4. If unresolved, use the [evidence and escalation template](docs/evidence-and-escalation.md).

## Safety defaults

- Diagnostics are read-only unless a section explicitly labels an action as human-gated.
- Never print tokens, passwords, cookies, authorization headers, private keys, credential-bearing URLs, or complete environment/configuration dumps.
- Never disable TLS verification as a workaround.
- Never clear shared caches, install global packages, weaken ACLs, or perform cross-root moves during ordinary triage.
- A delivery workaround is not a platform fix. The documentation labels them separately.
- Authentication, trust-store, connector-permission, dependency, infrastructure, and elevation changes require explicit human approval.

## Supported baseline

- Windows 11
- PowerShell 7 or Windows PowerShell 5.1
- Git and Codex local workspaces
- Python, Node.js, npm/pnpm, and GitHub CLI diagnostics

Commands for other operating systems must be added in separately labeled sections and verified on those systems.

## Repository policy

This repository intentionally has no runtime dependencies. The included PowerShell scripts use built-in commands and never print allowlisted environment-variable values. Diagnostic output still contains local-sensitive paths and repository metadata; review and redact it before sharing. See [Contributing](CONTRIBUTING.md) before adding diagnostics.

## Provenance

The handbook was synthesized under AmeenahsDevTeam work thread `T-2026-07-16-001` from actual consultations with Echo, Ledger, Beacon, Cipher, Cricket, and The Boulder. Consultation records are preserved in [`plans/correspondance/`](plans/correspondance/).

## Current limitations

- Network and authentication recovery cannot be verified without a working, authorized external connection.
- The Windows split-writable-root message is documented as a pre-execution sandbox-wrapper failure; the repository provides delivery recovery, not a platform patch.
- No software license has yet been selected. The repository is currently provided as a reference resource.

