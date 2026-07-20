# Windows papercuts

Verified baseline: Windows 11 with PowerShell 7 or Windows PowerShell 5.1, Git, Codex local workspaces, and common Python/Node/GitHub CLI tooling.

- [Sandbox and filesystem](sandbox-and-filesystem.md)
- [Read-only environment diagnostic](../../scripts/windows/diagnose-environment.ps1)

Start with the [shared quick triage](../shared/quick-triage.md), then use this lane for Windows paths, quoting, ACLs, worktrees, PowerShell, and restricted-token sandbox behavior.

Prefer the supported elevated Windows sandbox when policy permits it. A new
task may request one human UAC confirmation; cancellation is reported as
ShellExecuteExW error 1223 and is not proof of a code or filesystem defect.
Keep workspace-write and on-request approvals. Never use full-access or sandbox
bypass modes to work around setup failures.
