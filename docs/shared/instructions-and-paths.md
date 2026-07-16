# Instructions and paths

This page diagnoses environment failures involving instruction discovery, path ownership, quoting, and worktree placement. It does not define reusable skills or agent-routing policy.

## Codex instruction layers

Codex can combine global, project, and nested instruction files. When behavior appears inconsistent, first identify which files were actually in scope:

- Global `AGENTS.md`: user-level defaults.
- Project `AGENTS.md`: repository conventions and project overrides.
- Nested instructions: subtree-specific guidance.
- Registered skills: reusable workflows installed outside this papercuts repository.

A duplicated or stale rule can look like a runtime defect. Record the discovered files, their ownership layer, and the expected precedence before editing any of them.

## Skill-path symptoms

A project-relative path such as `.codex/skills/example/SKILL.md` and a user-global path beneath `$CODEX_HOME/skills` refer to different installations. For diagnosis:

- record which scope the caller expected;
- verify the path exists without printing the skill's private content;
- avoid expanding a user-profile path into tracked public documentation;
- stop before copying, rewriting, installing, or publishing a skill.

Reusable skill authoring, installation, synchronization, and project-scoped thread routing belong in the owner-controlled private skills repository. This page keeps only the environment symptom and handoff boundary.

## Windows path conventions

```powershell
$repo = Resolve-Path -LiteralPath '<repository-path>'
git -C "$repo" status --short --branch
Get-Content -Raw -LiteralPath (Join-Path $repo 'AGENTS.md')
```

- Use `-LiteralPath` for filesystem operations.
- Quote variables containing paths.
- Pass arguments directly or as arrays; avoid `Invoke-Expression`.
- Use `--` before ambiguous Git pathspecs.
- Resolve and inspect source and destination before a move.
- Use forward-slash repository-relative links in Markdown.

## Drift checks

```powershell
git status --short --branch
git ls-files -- AGENTS.md
rg -n --hidden -g '!.git/**' '[A-Za-z]:\\Users\\' .
git worktree list --porcelain
```

Compare declared ownership and invariants, not byte-for-byte copies that intentionally serve different scopes. If resolving the mismatch requires changing team operating policy or a reusable skill, stop the papercut investigation and hand the evidence to the appropriate private repository owner.
