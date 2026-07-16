# macOS papercuts

This is a contribution lane, not a claim that the Windows diagnostics work on macOS.

Before adding a fix, record:

- macOS version and architecture;
- shell and version;
- Codex surface/version;
- package manager and runtime versions;
- exact read-only reproduction and observed exit code;
- whether credentials come from Keychain, a CLI helper, or another named source;
- the smallest verified recovery and its stop condition.

Start with the [shared quick triage](../shared/quick-triage.md). Promote guidance here only after it has been run on macOS and reviewed for secret-safe output.
