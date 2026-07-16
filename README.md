# Papercuts and Skills

A dependency-free troubleshooting handbook for recurring Codex environment failures, plus the durable AmeenahsDevTeam skill and correspondence-routing conventions used to keep agent work consistent across projects.

The goal is classification before correction. Start with read-only evidence, identify the failing layer, permit at most one focused recovery, and escalate with a sanitized evidence packet when the recovery fails or requires additional authority.

## Start here

1. Read [Quick triage](docs/quick-triage.md).
2. Use the [live delivery-log default](docs/live-delivery-log.md) for any multi-step investigation or implementation.
3. Run the read-only [environment diagnostic](scripts/diagnose-environment.ps1) from PowerShell.
4. Open the guide for the classified failure:
   - [Instructions and paths](docs/instructions-and-paths.md)
   - [Runtimes and dependencies](docs/runtimes-and-dependencies.md)
   - [Windows sandbox and filesystem](docs/windows-sandbox-and-filesystem.md)
   - [Network, authentication, and TLS](docs/network-auth-and-tls.md)
5. If unresolved, use the [evidence and escalation template](docs/evidence-and-escalation.md).

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

## AmeenahsDevTeam skill and correspondence archive

The active global team skill is `C:\Users\SYEX8X/.codex/skills/ameenahs-dev-team/SKILL.md`. Project and global `AGENTS.md` files should point agents to that skill rather than copying or inventing a competing operating source.

Publishable AmeenahsDevTeam correspondence is indexed at:

- Website: [AmeenahsDevTeam Correspondence](https://ameenah-syed.github.io/ameenahs-dev-team-correspondance/)
- Source repository: [ameenahs-dev-team-correspondance](https://github.com/ameenah-syed/ameenahs-dev-team-correspondance)

For every substantive consultation, decision exchange, review, QA pass, conflict, publication action, or execution update:

1. Create the canonical detailed HTML artifact in the originating project's `plans/correspondance/` folder.
2. Include sender/recipient and thread IDs, status/type, request and constraints, bounded response, scope limits, evidence, conflict state, decision custody, exact verification, next actions, and publication boundary.
3. Send Raven the artifact path, status, one-sentence summary, verification state, and publication sensitivity in the standing role thread.
4. Do not publish directly unless Raven explicitly assigns that step. Protected content must be withheld or redacted and labeled.
5. Treat the website as the durable public index and the source HTML as the canonical record. A message is not an artifact, and an artifact is not published until deployment is verified.

## Provenance

The handbook was synthesized under AmeenahsDevTeam work thread `T-2026-07-16-001` from actual consultations with Echo, Ledger, Beacon, Cipher, Cricket, and The Boulder. Consultation records are preserved in [`plans/correspondance/`](plans/correspondance/).

## Current limitations

- Network and authentication recovery cannot be verified without a working, authorized external connection.
- The Windows split-writable-root message is documented as a pre-execution sandbox-wrapper failure; the repository provides delivery recovery, not a platform patch.
- No software license has yet been selected. The repository is currently provided as a reference resource.

