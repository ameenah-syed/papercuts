# Windows inconsistent task-launch bootstrap

## Symptom

A fresh Windows task can fail before its child process starts with
`CreateProcessAsUserW failed: 5`.

## Observed boundary

The failure can occur with the same project and working directory while a fresh
exact-root `workspace-write` task still fails. Survival of work through an
already-live or escalated task does not prove that ordinary fresh task launch is
healthy.

This points to per-task Windows sandbox identity and capability bootstrap,
possibly including divergence in a backend-cached effective mode. It is not a
repository, Git, current-directory, or worktree defect.

## Single discriminator experiment

Run exactly one fresh ordinary, non-elevated, network-restricted, read-only
task with zero writable roots. Its only command is `Get-Location`.

- A read-only success isolates the failure to writable-root capability or ACL
  preparation.
- The same pre-child failure isolates a common token or backend-bootstrap
  problem.

Stop after that one result.

## Required platform repair

Before child creation, atomically construct and validate the restricted token,
sandbox policy, and declared capabilities. On failure, emit structured
diagnostics that identify the failed bootstrap stage without exposing protected
content. Windows CI must exercise fresh tasks, prove inside-root access is
allowed, and prove outside-root access remains denied.

## Do not use bypasses

Do not recommend elevation, sandbox bypasses, repeated retries, or treating an
already-live task as a repair. Those may change delivery circumstances but do
not repair task-launch bootstrap.