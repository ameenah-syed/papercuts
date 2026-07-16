# Runtimes and dependencies

## The recurring mismatch

A tool may be installed but absent from `PATH`. A package may exist for one interpreter but not another. Resolve the executable first, then invoke its package manager through that executable.

```powershell
Get-Command node,npm,npx,pnpm,corepack,python,pip,py,gh -All -ErrorAction SilentlyContinue |
  Select-Object Name,CommandType,Source,Version

python -c "import sys; print(sys.executable); print(sys.version); print(sys.prefix)"
python -m pip --version
python -m pip check
```

## Rules

- Use `python -m pip`, never an unverified bare `pip`.
- Create a project-local virtual environment and keep packages out of host/global Python.
- Select exactly one Node package manager and commit exactly one matching lockfile.
- Treat bundled Codex runtimes as discoverable bootstrap tools, not project dependency declarations.
- Never commit absolute paths into versioned runtime caches.
- Validate resolved executable paths and versions on each diagnostic run.
- Preserve caches by default; clearing a shared cache is not a first-line fix.
- Prefer prebuilt wheels/packages. Stop before native compilation if the approved toolchain is missing.

## Project source of truth

Once a stack exists, commit the relevant runtime constraints, manifests, and lockfiles. A successful global import or package lookup does not prove clean-clone reproducibility.

## Stop conditions

- Multiple lockfiles or package managers become active.
- Python packages resolve outside the intended virtual environment.
- A command depends on an unvalidated internal cache path.
- Recovery requires global installation, persistent `PATH` edits, cache deletion, or system build tools.
- The dependency set is absent from a committed manifest/lockfile.
