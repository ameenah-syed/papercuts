# Instructions and paths

## Codex instruction layers

Codex normally combines global guidance with project and nested guidance. Treat each layer as having a different owner:

- Global `AGENTS.md`: small, stable user defaults.
- Project `AGENTS.md`: repository conventions and project-specific overrides.
- Nested instructions: subtree-specific rules.
- Skills: reusable workflows and detailed operating knowledge.

Avoid duplicating mutable policy across all layers. Prefer a concise pointer to one authoritative workflow and keep project exceptions local.

## Global versus project skills

A project-relative path such as `.codex/skills/example/SKILL.md` and a user-global path such as `$CODEX_HOME/skills/example/SKILL.md` are different installations. Do not move instructions between scopes without rewriting and verifying their references.

Tracked files should not contain expanded user-profile paths. Use `%USERPROFILE%` only in clearly Windows-specific runtime examples when necessary. Use repository-relative paths or documented discovery steps.

## Windows path conventions

```powershell
$repo = Resolve-Path -LiteralPath '<repository-path>'
git -C "$repo" status --short --branch
Get-Content -Raw -LiteralPath (Join-Path $repo 'AGENTS.md')
```

- Use `-LiteralPath` for filesystem operations.
- Quote variables containing paths.
- Pass arguments as arrays/direct parameters; avoid `Invoke-Expression`.
- Use `--` before ambiguous Git pathspecs.
- Resolve and inspect source and destination before any move.
- Use forward-slash repository-relative links in Markdown.

## Drift checks

```powershell
git status --short --branch
git ls-files -- AGENTS.md
rg -n --hidden -g '!.git/**' '[A-Za-z]:\\Users\\' .
git worktree list --porcelain
```

Compare invariants and declared ownership, not byte-for-byte copies that intentionally serve different scopes.

