# Windows sandbox and filesystem

## Split writable roots

**Evidence classification:** verified in the recorded project environment on Windows 11 on 2026-07-15 and 2026-07-16; broader applicability and affected Codex builds remain unverified.

The message below is a pre-execution sandbox-wrapper failure:

```text
windows unelevated restricted-token sandbox cannot enforce split writable root sets directly
```

In the recorded runs, it occurred before target-file access. Those observations do not establish NTFS denial, Git dirtiness, pytest cache trouble, or a bad target path. Shell and Git commands could still reach the same paths, indicating different enforcement paths in that environment. Repeating or waiting did not repair the wrapper failure.

### One focused delivery recovery

For the recorded environment, use one dedicated task whose cwd and sole declared repository workspace root are the exact worktree. If that is unavailable or repeats the failure, stop editing attempts and return a reviewed diff/evidence handoff to the integration owner.

This is a delivery workaround, not the platform fix. A platform fix must safely canonicalize and atomically enforce the complete writable-root collection without widening access.

### Supported elevated sandbox

When approved, configure the supported Windows elevated sandbox while retaining
workspace-write and on-request approvals, then start a new task. The expected
boundary is one interactive UAC confirmation. ShellExecuteExW error 1223 means
that confirmation was canceled before the child command ran. Do not edit UAC
registry policy, save administrator credentials, auto-click UAC, create a
highest-privilege scheduled task, or switch to full access.

If the elevated proof is unavailable, use the one-root launcher first. A
reviewed patch runner is a last-mile delivery mechanism only: a separate
reviewer approves the exact SHA-256, the operator enters it interactively, and
the runner revalidates repository identity, path safety, and git apply --check.
It remains **OPERATIONAL WORKAROUND - DOES NOT FIX CODEX SPLIT-ROOT SANDBOX**.

The read-only diagnostic reports only the configured sandbox mode, whether the
current token is elevated, and whether a sandbox log exists. It does not read
the log or inspect protected credential stores.

## Worktrees

- Place issue worktrees under `<repo>/.worktrees/<thread-or-issue>`.
- Do not use `%TEMP%`, `C:\tmp`, or a global Codex worktree directory for project worktrees.
- Use one editor per branch/worktree.
- Ensure `.worktrees/` is ignored before creation.

## Cross-root operations

Analyze source and destination first. Cross-root moves can cross permission boundaries and can be interrupted between copy and delete. Prefer staged copy â†’ hash verification â†’ explicit source removal when a move is approved.

Never recursively delete or move an unresolved/computed path. Verify its canonical absolute path remains inside the intended boundary.

## Temporary launchers

An elevated security context may be unable to execute a temporary launcher created for the unelevated context. Record the exact path, signer status, identity class, error code, and whether denial occurred before execution. Do not weaken ACLs or security controls as a shortcut.

