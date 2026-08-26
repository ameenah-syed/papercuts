# macOS papercuts

This is a contribution lane, not a claim that the Windows diagnostics work on macOS.

Before adding a fix, record:

- macOS version and architecture;
- shell and version;
- Codex surface/version;
- package manager and runtime versions;
- exact read-only reproduction and observed exit code;
- whether credentials come from Keychain, a CLI helper, or another named source;
- the smallest verified recovery and its stop condition.

Start with the [shared quick triage](../shared/quick-triage.md). Promote guidance here only after it has been run on macOS and reviewed for secret-safe output.

## AutoClean uv/MNE/PyQt test crashes

Verified on macOS in zsh while testing an uv-managed AutoClean source checkout.

### Symptoms

- `uv` dependency setup or execution may fail when the default user cache is not writable from the current sandbox.
- MNE may fail while trying to lock the user home config file, commonly under `.mne/mne-python.json.lock`.
- A broad pytest run that imports the Exclude/GUI path may trigger a macOS "Python quit unexpectedly" dialog instead of a normal Python traceback. In the observed case this was tied to the Qt/PyQt GUI import path in a non-GUI test context.

### Verified recovery

For dependency sync when the normal uv cache is blocked:

```bash
UV_CACHE_DIR=/private/tmp/autoclean-uv-cache uv sync --extra dev
```

For targeted test execution:

```bash
MNE_DONTWRITE_HOME=true QT_QPA_PLATFORM=offscreen uv run --no-cache --extra dev pytest tests/integration/test_ica_prerejection_report.py tests/unit/mixins/test_ica.py -q --disable-warnings --maxfail=1
```

For a one-off script, keep the same environment guardrails around the user's command:

```bash
MNE_DONTWRITE_HOME=true QT_QPA_PLATFORM=offscreen uv run --no-cache python your_script.py
```

### What each part does

- `UV_CACHE_DIR=/private/tmp/autoclean-uv-cache` redirects uv's cache away from a blocked home-cache path during setup.
- `uv run --no-cache` avoids relying on a stale or inaccessible uv execution cache.
- `MNE_DONTWRITE_HOME=true` tells MNE not to write or lock the user's home config during the run.
- `QT_QPA_PLATFORM=offscreen` keeps Qt/PyQt imports from trying to attach to a normal macOS GUI display during headless or sandboxed tests.

### Evidence and limits

The targeted AutoClean ICA report tests completed with `37 passed`; the command's process exit was still nonzero because the repository-wide coverage threshold is enforced even for a narrow targeted run. That is a coverage-policy mismatch for targeted debugging, not a test failure.

This is a delivery workaround for local/sandboxed macOS test runs. It is not a repo-level fix for GUI import behavior, coverage configuration, or persistent uv/MNE settings.
