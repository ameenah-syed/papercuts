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


### Setup-refresh ACE failure on `C:\tmp`

**Evidence classification:** verified in a Windows ICVision code-edit task in July 2026. The broader affected build range remains unverified.

Another pre-file-access signature is:

```text
windows sandbox failed: helper_unknown_error: setup refresh had errors
write ACE failed on C:\tmp: SetNamedSecurityInfoW failed: 5
```

This means the filesystem helper attempted to prepare a declared global writable
root and failed before `apply_patch` could inspect the requested source file.
It does not prove that the project worktree, Git index, patch contents, or
target file permissions are bad. Ordinary shell/tests can still work because
they may not use the helper's ACL setup path.

Use one fresh dedicated code-edit task with the exact canonical worktree as its
sole writable root. If temporary files are required, use a declared scratch
directory inside that worktree. First run one reversible `apply_patch` probe;
if it fails, stop and preserve the exact error. Do not broaden ACLs on `C:\tmp`,
disable the sandbox, use full access, or assume a Git patch application repairs
the helper. A successful one-root task is a delivery proof, not the platform
fix for multi-root policy compilation.

### Clean-clone integration surface when generic writers are blocked

**Evidence classification:** verified in a Windows ICVision delivery run on
2026-07-22. This is an operational workaround, not a Codex sandbox repair.

In the same project, a newly created standalone Git clone under the repository
root could create and remove a harmless probe file, while generic PowerShell
writers such as `Copy-Item` and `Set-Content` were blocked before they ran in
the original linked worktree. Git-native application of a reviewed patch that
was derived from an existing source file succeeded in the clone.

Use this only after preserving the original worktree unchanged:

1. Create a clean standalone clone on the intended branch beneath the project
   root; it must have its own `.git` directory and one sole editor.
2. Prove that surface with a reversible create/delete probe.
3. Transfer only an exact reviewed diff or explicitly identified files. Run
   `git apply --check` before `git apply`, then inspect `git diff` and run the
   focused test.
4. Keep the original drafts intact until the new checkout has independent
   review and verification. Do not edit both checkouts concurrently.

This isolates a temporary delivery path. It does **not** establish that linked
worktrees are the cause, repair the Windows helper's task-wide writable-root
policy, justify ACL changes to `C:\tmp`, or authorize unrestricted shell/file
access. If the clone fails its reversible probe, stop and record the exact
failure instead of creating more checkouts.
