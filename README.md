# Codex Environment Papercuts

A public, dependency-free field guide for diagnosing recurring Codex environment failures across Windows, macOS, and Linux.

This repository exists for the small failures that repeatedly interrupt otherwise straightforward agent work: a tool exists but is not on `PATH`; the wrong Python interpreter owns a package; a sandbox rejects a writable-root layout before a command starts; Git credentials work in one client but not another; TLS, proxy, or temporary-directory behavior differs from the expected host. These failures are usually environment-specific, so the guide separates portable diagnostic reasoning from operating-system evidence.

The operating principle is simple:

> Classify first, collect minimal evidence, try one bounded recovery, verify the result, and stop when the next action needs human authority.

## Who this is for

Use this repository when:

- a Codex task cannot start or complete because of the host environment;
- a command behaves differently across machines, shells, users, containers, or CI;
- an agent needs a safe evidence packet for a platform or authentication escalation;
- a team wants to add a reproducible Windows, macOS, or Linux papercut without turning the guide into an automation framework.

It is useful to agents, engineers, reviewers, and maintainers. It assumes the reader can run basic shell commands, but the diagnostic flow is intentionally conservative and explicit about side effects.

## What belongs here

Papercuts owns environment-dependent troubleshooting:

- executable and runtime discovery;
- interpreter and package-manager mismatch;
- filesystem paths, quoting, permissions, and worktree placement;
- sandbox and temporary-directory failures;
- proxy, TLS, authentication, and connector-boundary classification;
- dependency and cache observations;
- read-only diagnostics, evidence templates, and escalation stop conditions;
- verified differences between Windows, macOS, and Linux.

This repository does **not** own reusable Codex skills, agent operating policy, project-specific thread routing, product workflows, secrets, private repository material, or unattended remediation. Reusable workflows and their installation/routing policy live in the owner-controlled private skills repository. Historical consultation artifacts remain here as provenance; they are records, not active skill payloads.

## Choose the relevant lane

| Lane | Current status | Use it for |
| --- | --- | --- |
| [Shared](docs/shared/README.md) | Portable diagnostic method | Classification, evidence, escalation, dependency triage, and delivery-state recording |
| [Windows](docs/windows/README.md) | Verified on Windows 11 | PowerShell, Windows paths, restricted-token sandbox behavior, and the read-only diagnostic |
| [macOS](docs/macos/README.md) | Contribution lane | Verified macOS-specific reproductions and recoveries |
| [Linux](docs/linux/README.md) | Contribution lane | Distribution-, container-, WSL-, SSH-, or CI-specific evidence |

Windows is the only verified platform at the time of this README. The macOS and Linux directories define evidence requirements; they do not claim that Windows commands work there.

## Diagnostic workflow

1. **Confirm the context.** Record the operating system, shell, Codex surface, working directory, repository, and relevant tool versions.
2. **Start with [Quick triage](docs/shared/quick-triage.md).** Choose one primary failure class instead of trying unrelated fixes.
3. **Collect read-only evidence.** Prefer executable identity, version, exit code, sanitized path shape, and repository state over full environment dumps.
4. **Use the platform lane.** On Windows, the [environment diagnostic](scripts/windows/diagnose-environment.ps1) provides a dependency-free baseline.
5. **Attempt one focused recovery.** Define the expected success signal before changing anything.
6. **Verify narrowly.** Repeat the smallest command that proves or disproves the recovery.
7. **Stop and escalate.** Use the [evidence and escalation template](docs/shared/evidence-and-escalation.md) when the problem repeats, crosses an authority boundary, or needs changes to credentials, trust, dependencies, infrastructure, or permissions.

For multi-step work, use the [live delivery log](docs/shared/live-delivery-log.md) so another owner can distinguish active progress from waiting, blocking, and completion.

## Repository map

```text
docs/
  shared/        Portable diagnostic method and evidence contracts
  windows/       Verified Windows guidance
  macos/         macOS contribution and verification lane
  linux/         Linux contribution and verification lane
scripts/
  windows/       Read-only Windows environment diagnostic
  verify-repository.ps1
plans/
  correspondance/ Historical canonical consultation artifacts
github/          Historical repository planning record
```

The historical files under `plans/correspondance/` and `github/` preserve how the guide was created and published. Do not treat historical repository names, decisions, or URLs inside those records as current operating instructions.

## Running the Windows diagnostic

From the repository root:

```powershell
powershell.exe -NoProfile -File .\scripts\windows\diagnose-environment.ps1
```

If PowerShell 7 is available:

```powershell
pwsh -NoProfile -File ./scripts/windows/diagnose-environment.ps1
```

The diagnostic is designed to be read-only and dependency-free. Its output can still contain local-sensitive paths, executable locations, repository names, and tool metadata. Review and redact the output before putting it in a public issue or correspondence record.

## Safety model

- Never print tokens, passwords, cookies, authorization headers, private keys, credential-bearing URLs, or complete credential/configuration stores.
- Never disable TLS verification to make a request pass.
- Never weaken ACLs, elevate, install global packages, clear shared caches, or move work across roots during ordinary triage.
- Treat authentication, authorization, connector permissions, trust stores, dependencies, infrastructure, and destructive actions as explicit human gates.
- Distinguish a platform/root-cause fix from a temporary delivery workaround.
- Do not call a check successful unless its command, environment, exit code, and relevant output were observed.
- Do not generalize one operating system, distribution, or shell result to another without evidence.

## Contributing a papercut

Read [CONTRIBUTING.md](CONTRIBUTING.md) before adding guidance. A useful contribution includes:

- exact environment and versions;
- a minimal, read-only reproduction;
- expected and observed behavior;
- sanitized evidence;
- primary failure classification;
- one bounded recovery and its success signal;
- known side effects and authority gates;
- a deterministic check or fixture when practical.

Put portable reasoning in `docs/shared/`, OS-specific guidance in the matching `docs/<os>/` directory, and executable diagnostics in `scripts/<os>/`. Do not add `SKILL.md` files or reusable agent workflows here.

## Verifying the repository

On Windows:

```powershell
powershell.exe -NoProfile -File .\scripts\verify-repository.ps1
```

or:

```powershell
pwsh -NoProfile -File ./scripts/verify-repository.ps1
```

The verifier checks required files, all platform lanes, the absence of skill payloads, and generic machine-profile-path leakage. It does not prove that every documented recovery works on every environment.

## Provenance and public records

The original Windows handbook was synthesized under AmeenahsDevTeam work thread `T-2026-07-16-001`. The public/private repository split was completed under `T-2026-07-16-007`. The consultation records remain in [`plans/correspondance/`](plans/correspondance/), and publishable team records are indexed in the [AmeenahsDevTeam correspondence archive](https://ameenah-syed.github.io/ameenahs-dev-team-correspondance/).

## Current limitations

- Windows is the only verified platform lane.
- Network and authentication recoveries require a working, authorized external connection to verify.
- The documented Windows split-root failure is a pre-execution sandbox-wrapper classification, not a platform patch.
- This repository intentionally offers diagnostic guidance, not automatic repair.
- No software license has been selected; the repository is currently provided as a public reference resource.
