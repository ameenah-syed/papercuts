# Quick triage


## 0. Make state visible

For any multi-step investigation or implementation, begin and maintain a compact delivery log using [the default format](live-delivery-log.md). Show the current state, responsible owner, verified evidence, decision or blocker, and next action. A command or delegated task is `active` only while it is actually running; use `waiting`, `blocked`, or `complete` otherwise.
## 1. Classify one primary symptom

| Class | Typical evidence | First action |
|---|---|---|
| Invocation/context | Command not found, wrong cwd/worktree | Resolve cwd, repository root, and executable |
| Instruction/path | Wrong guidance, unresolved relative path | Identify loaded instruction layers and canonical path |
| Runtime mismatch | Wrong Python/Node or package owner | Pair executable with its package manager |
| Lock/resolution drift | Missing package, frozen-lock failure | Compare manifest and lockfile; do not update yet |
| Sandbox wrapper | Split writable roots, pre-execution refusal | Record every advertised root; try one exact-root task |
| Filesystem/temp/cache | Access denied or fatal temp/cache error | Identify the exact target and owning root |
| Network/proxy | DNS, TCP, timeout, refused proxy | Test transport without credentials |
| TLS trust | Issuer-chain or certificate validation error | Verify expected CA provenance; never bypass validation |
| Authentication | 401/403, invalid keyring credential | Stop; use supported interactive refresh after approval |
| Native build | Missing compiler, SDK, DLL, or ABI | Prefer prebuilt artifacts; stop before installing toolchains |
| Code regression | Install succeeds but named check fails | Route to engineering/CI, not environment triage |
| Stall/resource | No output or progress evidence | Apply two 30-second checkpoints |
| Unknown | Evidence fits no class | Stop and escalate |

## 2. Capture evidence

Record the exact command, cwd, repository root, branch, dirty state, resolved executable, relevant writable roots, timing, exit code, sanitized error, and whether files changed.

Do not collect complete environment dumps, credential stores, verbose HTTP traces, or raw package-manager configuration.

## 3. Permit one focused recovery

Change one suspected cause and rerun the smallest failing command once. Define the success signal first. Do not combine runtime changes, cache deletion, upgrades, installs, and broad test runs.

## 4. Stop and escalate

Stop when the recovery repeats the same failure, requires broader authority, could reveal secrets, changes a manifest or lockfile, needs elevation, disables a security boundary, or cannot be verified.

Use [the escalation template](evidence-and-escalation.md).
