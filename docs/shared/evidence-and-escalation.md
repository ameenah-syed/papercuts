# Evidence and escalation

## Sanitized incident record

```text
Run ID:
Started/ended:
Operator/agent role:
Source thread ID:
Local work thread ID:

Repository and cwd:
Branch and dirty baseline:
Advertised writable roots:
Exact command:
Resolved executable:
Runtime/package-manager versions:
Manifest/lockfile names and hashes:

Primary classification:
Secondary factors:
Exit code or exact sanitized error:
Time of last output:
Filesystem/diff changes:

Focused recovery:
Changed variable and hypothesis:
Authorization status:
Expected success signal:
Verification result:

Current owner:
Human input required:
Next action:
Stop reason:
```

## Claim labels

- **Verified:** directly supported by a command, file, or authoritative source.
- **Inferred:** best explanation from available evidence; not directly proven.
- **Expected:** predicted result for a documented procedure.
- **Unverified:** evidence is unavailable or blocked.

Never turn “not evaluated” into a pass.

## Stall rule

Apply the two-checkpoint rule only to an attributable running command or process.

At 30 seconds without attributable progress, inspect that command's process state, Git diff, and relevant timestamps once. If no command is running, ask once for the concrete blocker and next action instead of inventing a process stall.

At the next consecutive 30-second checkpoint, continue only when attributable evidence advances within the declared budget. Otherwise stop the current execution path and change strategy. Never restart the same workflow unchanged.

Model context loading or reasoning is not a subprocess. If reasoning becomes the delay, reduce the work packet or request the next concrete action instead of adding more monitoring.

Every retry must name the evidence-backed hypothesis, the materially changed variable, and the expected success signal. Prompt rewording alone is not a changed variable.

See [Retry and stall churn](retry-and-stall-churn.md) for the full diagnosis and corrected flow.

## Mandatory escalation

Escalate when secrets appear, the authority boundary expands, verification is unavailable, the same failure repeats after one focused changed-variable recovery, the fix changes a manifest/lockfile or protected configuration, TLS trust is uncertain, or the proposed fix is actually an unowned workaround.
