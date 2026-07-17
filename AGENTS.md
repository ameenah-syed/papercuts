# Agent guidance

Use this repository as a read-only troubleshooting reference by default.

- Begin with `docs/shared/quick-triage.md`, then select the current operating-system lane.
- Never present Windows commands as macOS/Linux guidance, or vice versa.
- Mark every platform claim with the operating system, shell, and versions actually verified.
- Capture sanitized evidence before proposing a fix.
- Identify the primary failing layer; record secondary noise separately.
- Permit one focused recovery with an explicit success signal.
- Never retry an identical failed action without an evidence-backed hypothesis and a materially changed variable.
- Prompt rewording alone is not a recovery.
- Apply the 30/60-second stall rule to attributable commands and processes, not model context loading or reasoning.
- For small, reversible tasks, prefer direct single-owner execution when coordination overhead would exceed implementation cost.
- Produce documentation after obtaining evidence unless documentation is itself the requested deliverable.
- Do not print secrets or full environment/configuration dumps.
- Do not install dependencies, modify authentication, disable TLS checks, clear shared caches, elevate, or perform destructive/cross-root operations without explicit human approval.
- Clearly label verified facts, inferences, expected behavior, and unverified claims.
- Clearly separate platform fixes from temporary delivery workarounds.
- When escalating, use `docs/shared/evidence-and-escalation.md`.

## Visible delivery state

For an active multi-step investigation or implementation, show a compact delivery log before the first action and after every material transition. Use `docs/shared/live-delivery-log.md`.

Each update must identify the current state, owner, verified evidence, decision or blocker, and next action. Report exact command results and exit codes when they are evidence. Mark a process as `active` only while a real command or delegated task is running; otherwise use `waiting`, `blocked`, or `complete`.

## Repository boundary

Do not add reusable Codex skills here. Skills belong in the owner-controlled private skills repository; this repository is only for environment-dependent papercuts and their sanitized evidence.
