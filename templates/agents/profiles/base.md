## Python Package Profile

This is a Python package managed with `uv`.

* Source code: `src/__PACKAGE_NAME__/`
* Tests: `tests/`
* Python version: `__PYTHON_VERSION__`

## Commands

```powershell
uv sync --dev
.\scripts\check.ps1
.\scripts\fix.ps1
```

Use `uv add` or `uv add --dev` for dependencies.

Before claiming completion, run the focused check first, then `.\scripts\check.ps1` when feasible.
