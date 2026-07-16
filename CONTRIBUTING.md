# Contributing

Contributions should make diagnosis safer, narrower, more portable, and more reproducible.

## Requirements

- Put portable material in `docs/shared/`.
- Put operating-system material in `docs/windows/`, `docs/macos/`, or `docs/linux/`.
- Put executable diagnostics in the matching `scripts/<os>/` folder.
- Label the operating system, version/distribution, shell, tool version, prerequisites, working directory, command, expected output, and observed result.
- Keep default diagnostics read-only and dependency-free.
- Use repository-relative paths in tracked documentation.
- Never include real credentials, private URLs, usernames, machine-local paths, or organizational metadata.
- Explain command side effects and human approval gates.
- Separate root-cause/platform fixes from workarounds.
- Do not promote a macOS or Linux placeholder to verified guidance until it has been run on that environment.

## Verification

From Windows:

```powershell
pwsh -NoProfile -File ./scripts/verify-repository.ps1
```

If `pwsh` is unavailable:

```powershell
powershell.exe -NoProfile -File .\scripts\verify-repository.ps1
```

Do not report a check as passing without the exact command, environment, exit code, and relevant output.
