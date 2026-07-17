# Retry and stall churn

This page diagnoses a portable coordination papercut: an engineering task stops making useful progress because the recovery process repeats polling, prompting, stopping, or restarting without changing the underlying strategy.

It does not define reusable agent policy. It provides public, environment-neutral diagnostic reasoning and a bounded recovery pattern.

## Symptom

Typical signs include:

- coordination and status reporting take longer than implementation;
- a missing Git diff is treated as proof that work is stalled;
- the same task is resent with a longer prompt;
- an agent or command is restarted without identifying the blocker;
- repeated polling produces no new decision-relevant evidence;
- governance, correspondence, review, and publication planning delay the first reversible edit;
- a real permission or runtime failure is buried beneath generic “still working” states.

## Minimal reproduction

1. Assign a small, reversible change with a focused offline test.
2. Bundle implementation, reporting, recovery, review, and publication requirements into the initial work packet.
3. Check only for output or filesystem changes.
4. If no diff appears, stop and resend substantially the same task.
5. Repeat without changing permissions, scope, owner, command, input, or implementation approach.

## Expected and observed behavior

**Expected:** Identify the first concrete blocker, change one relevant variable, perform the smallest reversible action, and verify it.

**Observed:** Repeat coordination actions without a new hypothesis. Supervision becomes the primary activity while implementation remains untouched.

## Primary classification

Classify this as **coordination/retry churn**, not automatically as a command stall, filesystem defect, or code regression.

Secondary factors may include oversized context, instruction duplication, Git metadata permissions, sandbox policy, test temporary-directory access, unclear requirements, or an actual slow command. Keep the primary coordination failure separate from any secondary environmental blocker.

## Diagnosis

### Retry without a changed hypothesis

A retry is useful only when evidence supports a different expected result. At least one relevant variable must change, such as:

- command scope;
- permissions;
- working directory or writable root;
- executable or runtime;
- dependency state;
- test target;
- input;
- implementation approach;
- responsible owner.

Prompt rewording alone is not a materially different experiment.

### Oversized work packets

Small code changes should not begin with every later lifecycle requirement. An initial packet should contain the desired behavior, non-goals, likely code surface, first reversible action, focused test, and safety boundaries. Review, publication, and correspondence follow when implementation evidence exists.

### Incorrect stall signal

“No diff yet” is not enough to classify a stall. It can mean context loading, investigation, active design, a blocked command, or inactivity.

The first diagnostic question is:

> What concrete action is running or blocked right now?

### Coordination cost exceeds implementation cost

Use one owner for a small, bounded task. Delegation is valuable when specialization, parallelism, or independent verification offsets its overhead. Otherwise, direct execution is the shorter and more observable path.

## Bounded recovery

1. Stop repeated polling.
2. Identify the exact current action.
3. Assign one primary failure class.
4. Record the leading hypothesis.
5. Change one relevant variable.
6. State the expected success signal.
7. Run the smallest experiment once.
8. If it fails in the same way, stop that strategy and escalate or choose a materially different path.

Do not combine permission changes, dependency updates, cache deletion, worktree moves, and broad tests into one recovery.

## Corrected engineering flow

### 1. Size the task

- **Small and bounded:** one owner executes directly.
- **Specialized:** route once to the relevant specialist.
- **Parallelizable:** divide by non-overlapping ownership.
- **High risk:** add explicit human gates and independent verification.

### 2. Reduce the batch

1. Create or select the reversible branch.
2. Make one small edit.
3. Run one exact offline check.
4. Inspect the diff.
5. Expand only to the focused test set.
6. Request independent review.
7. Document verified results.
8. Request separate approval for risky external actions.

### 3. Diagnose failures by layer

| Failure class | First diagnostic action | Changed strategy example |
|---|---|---|
| Git metadata | Identify the exact lock/ref path and operation | Authorize only the required Git metadata write |
| Sandbox wrapper | Record the declared-root policy and pre-execution error | Use one exact-root task or reviewed-diff handoff |
| Filesystem/temp | Resolve the exact denied target and owning root | Use one verified writable test temp root |
| Runtime/dependency | Pair the executable with its package manager | Select the correct interpreter; do not upgrade broadly |
| Code/test | Run the smallest named failing test | Patch one behavior and rerun that test |
| Coordination/retry | Identify the current blocker and next command | Reduce scope or use the existing owner directly |
| Unknown | Preserve evidence | Stop and escalate |

A scoped workaround must remain labeled as an interim unblock when the platform root cause is elsewhere.

## Amended stall handling

The two-checkpoint rule applies to an attributable running command or process.

At the first checkpoint without progress evidence:

1. inspect the command, process, diff, and relevant timestamps once;
2. determine whether a command is actually running;
3. if no command is running, ask once for the concrete blocker and next action;
4. select one changed strategy.

At the second checkpoint:

- continue only if attributable evidence advances;
- otherwise stop the current execution path;
- do not restart the same workflow unchanged.

Model context loading or reasoning is not a subprocess. Do not apply a command-timeout rule mechanically to it. If reasoning becomes the delay, reduce the work packet or request the next concrete action instead of adding more monitoring.

## Verification checklist

- [ ] The first concrete blocker is named.
- [ ] The retry changes a relevant variable.
- [ ] The expected success signal is defined before recovery.
- [ ] One small edit precedes broad review or documentation.
- [ ] The first test is exact, offline, and bounded.
- [ ] A second same-class failure stops that strategy.
- [ ] No duplicate owner edits the same branch.
- [ ] Coordination time is proportionate to implementation risk.
- [ ] Credentials, live services, external data transfer, destructive operations, publication, merge, and release remain human-gated.

## Stop conditions

Stop and escalate when the same failure repeats after one changed-variable recovery, no concrete blocker can be identified, the next action expands authority, verification is unavailable, sensitive boundaries are involved, or coordination overhead continues to exceed the bounded implementation without risk justification.

The desired loop is:

> observe → classify → form a hypothesis → change one variable → execute → verify

—not:

> wait → poll → resend → restart → repeat.
