# Live delivery-log default

Use this format for every active multi-step investigation, implementation, review, or publication flow. Keep it in the user-facing working stream; do not make the user request a status check.

```markdown
### Delivery log ? <work ID>

| Stage | State | Owner / verified evidence | Next action |
|---|---|---|---|
| Intake / preflight | complete | <scope and starting invariant> | <action> |
| Implementation or recovery | active | <running command or task> | <success signal> |
| Review / QA | waiting | <required reviewer or test> | <handoff> |
| Commit / publish | blocked | <specific authority or infrastructure gate> | <what unblocks it> |
```

## Rules

- Emit an initial log before taking action, then update it at each material transition: start, handoff, command completion, test result, review result, failure, gate, and completion.
- State only verified facts. Include the exact command, working directory, exit code, test count, task identifier, commit, or remote result when it supports the claim.
- Use `active` only for work actually in flight. Use `waiting` for a dependency, `blocked` for a specific unmet condition, and `complete` only after the stated success signal is verified.
- Name the current owner. If no person or task owns a next action, make that gap visible and assign or escalate it.
- Separate a platform root-cause fix from an interim delivery unblock in both the evidence and the next action.
- Keep the log compact. Expand only the failed or gated row with the minimum evidence needed to make the next decision.
- Do not use repeated idle polling as progress. Poll only when it has a defined purpose, cadence, and stop condition.
- On completion, show the final artifact, verification evidence, remaining known limits, and any required human handoff.

## State vocabulary

| State | Meaning |
|---|---|
| `active` | A named command or task is currently running. |
| `waiting` | A named dependency is expected; no work is currently running. |
| `blocked` | A specific authority, environment, safety, or quality condition prevents the next action. |
