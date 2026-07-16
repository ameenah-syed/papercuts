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
