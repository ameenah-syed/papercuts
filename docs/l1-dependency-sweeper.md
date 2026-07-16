# Optional L1 dependency sweeper

This is a report-only pattern, not an active automation.

## Readiness prerequisites

- At least one recognized manifest exists.
- The supported package manager and lockfile policy are documented.
- Raven names an owner and state location.
- Network-read permissions and private-registry handling are defined.
- A human-triggered baseline has been reviewed.

## Allowed behavior

- Inventory manifests and lockfiles.
- Report missing, duplicate, or inconsistent lockfiles.
- Record declared runtime constraints and resolved local versions.
- Run explicitly configured read-only consistency/audit commands.
- Deduplicate findings and draft handoffs.

## Forbidden behavior

The sweeper must not install, update, rewrite lockfiles, run arbitrary lifecycle scripts, open issues, notify broadly, or fix vulnerabilities. Dependency and security changes remain human-gated.

## Waste controls

Deduplicate by classification, command, repository, runtime, and manifest/lock hashes. Do not repeatedly alert on an unchanged escalated finding. Stop when false positives, notification volume, or diagnosis time exceed actionable value.
