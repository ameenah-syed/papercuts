# Agent guidance

Use this repository as a read-only troubleshooting reference by default.

- Begin with `docs/quick-triage.md`.
- Capture sanitized evidence before proposing a fix.
- Identify the primary failing layer; record secondary noise separately.
- Permit one focused recovery with an explicit success signal.
- Do not print secrets or full environment/configuration dumps.
- Do not install dependencies, modify authentication, disable TLS checks, clear shared caches, elevate, or perform destructive/cross-root operations without explicit human approval.
- Clearly label verified facts, inferences, expected behavior, and unverified claims.
- Clearly separate platform fixes from temporary delivery workarounds.
- When escalating, use `docs/evidence-and-escalation.md`.

## Visible delivery state

For an active multi-step investigation or implementation, show a compact delivery log in the user-facing working stream before the first action and after every material transition. Use the format in `docs/live-delivery-log.md`.

Each update must identify the current state, owner, verified evidence, decision or blocker, and next action. Report exact command results and exit codes when they are evidence. Mark a process as `active` only while a real command or delegated task is running; otherwise use `waiting`, `blocked`, or `complete`. Do not replace progress visibility with idle polling or retrospective summaries.
