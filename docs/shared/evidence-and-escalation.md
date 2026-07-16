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

At 30 seconds without output, inspect attributable process progress, Git diff, and relevant timestamps. At the next consecutive 30-second checkpoint with no evidence of progress, classify the command as stalled and stop it safely. If evidence advances, classify it as active-slow and allow it only to its declared budget.

## Mandatory escalation

Escalate when secrets appear, the authority boundary expands, verification is unavailable, the same failure repeats after one focused recovery, the fix changes a manifest/lockfile or protected configuration, TLS trust is uncertain, or the proposed fix is actually an unowned workaround.
