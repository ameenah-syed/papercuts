# Contributing

Contributions should make diagnosis safer, narrower, and more reproducible.

## Requirements

- Keep default diagnostics read-only and dependency-free.
- Label the operating system, shell, tool version, prerequisites, working directory, and expected output.
- Use repository-relative paths in tracked documentation.
- Use `-LiteralPath`, argument arrays, and quoted variables in PowerShell examples.
- Add a deterministic fixture or mock for new failure classifications where practical.
- Never include real credentials, private URLs, usernames, machine-local paths, or organizational metadata.
- Explain command side effects and human approval gates.
- Separate root-cause/platform fixes from workarounds.

## Verification

Run from the repository root:

```powershell
pwsh -NoProfile -File ./scripts/verify-repository.ps1
```

If `pwsh` is unavailable, Windows PowerShell can run the same script:

```powershell
powershell.exe -NoProfile -File .\scripts\verify-repository.ps1
```

Do not report a check as passing without the exact command, environment, exit code, and relevant output.

