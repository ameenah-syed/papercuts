# Linux papercuts

This is a contribution lane. Linux behavior must name the distribution, release, architecture, shell, init/container context, and package manager that were actually tested.

Before adding a fix, record:

- distribution/release and architecture;
- shell and version;
- Codex surface/version;
- native, container, WSL, SSH, or CI context;
- exact read-only reproduction and observed exit code;
- the smallest verified recovery and its stop condition.

Start with the [shared quick triage](../shared/quick-triage.md). Do not generalize one distribution's behavior to all Linux environments without evidence.
