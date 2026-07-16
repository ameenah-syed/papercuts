# Codex Environment Papercuts

A public, dependency-free troubleshooting handbook for recurring Codex environment failures. Papercuts are organized by operating system because paths, shells, sandboxes, package managers, credentials, and filesystem behavior differ across Windows, macOS, and Linux.

The goal is classification before correction: gather read-only evidence, identify the failing layer, permit at most one focused recovery, and escalate with a sanitized evidence packet when the recovery fails or requires additional authority.

## Choose your environment

| Environment | Status | Start here |
| --- | --- | --- |
| Windows | Documented and checked on Windows 11 | [Windows guide](docs/windows/README.md) |
| macOS | Contribution lane; commands must be verified on macOS before promotion | [macOS guide](docs/macos/README.md) |
| Linux | Contribution lane; commands must be verified on a named distribution before promotion | [Linux guide](docs/linux/README.md) |
| Shared | Portable classification, evidence, and escalation guidance | [Shared guide](docs/shared/README.md) |

## Start here

1. Read [Quick triage](docs/shared/quick-triage.md).
2. Use the [live delivery-log default](docs/shared/live-delivery-log.md) for multi-step investigations.
3. Select the guide for the current operating system.
4. On Windows, run the read-only [environment diagnostic](scripts/windows/diagnose-environment.ps1).
5. If unresolved, use the [evidence and escalation template](docs/shared/evidence-and-escalation.md).

## Safety defaults

- Diagnostics are read-only unless a section explicitly labels an action as human-gated.
- Never print tokens, passwords, cookies, authorization headers, private keys, credential-bearing URLs, or complete environment/configuration dumps.
- Never disable TLS verification as a workaround.
- Never clear shared caches, install global packages, weaken ACLs, or perform cross-root moves during ordinary triage.
- A delivery workaround is not a platform fix. The documentation labels them separately.
- Authentication, trust-store, connector-permission, dependency, infrastructure, and elevation changes require explicit human approval.

## Repository boundaries

This repository contains environment-dependent papercuts only. Cross-system Codex skills live in the owner-controlled private skills repository. Publishable AmeenahsDevTeam correspondence remains in the [correspondence archive](https://ameenah-syed.github.io/ameenahs-dev-team-correspondance/).

The handbook intentionally has no runtime dependencies. Diagnostic output can still contain local-sensitive paths and repository metadata; review and redact it before sharing. See [Contributing](CONTRIBUTING.md) before adding diagnostics.

## Provenance

The original Windows handbook was synthesized under AmeenahsDevTeam work thread `T-2026-07-16-001`. Its consultation records remain in [`plans/correspondance/`](plans/correspondance/). The repository split and environment taxonomy were recorded under `T-2026-07-16-007`.

## Current limitations

- Windows is the only verified environment at the time of the split.
- macOS and Linux lanes intentionally contain verification requirements rather than copied Windows commands.
- Network and authentication recovery cannot be verified without a working, authorized external connection.
- The Windows split-writable-root message is documented as a pre-execution sandbox-wrapper failure; this repository provides delivery recovery, not a platform patch.
- No software license has yet been selected. The repository is provided as a reference resource.
