## Desktop Profile

This is a PySide6 desktop app managed with `uv`.

* App entrypoint: `src/__PACKAGE_NAME__/__main__.py`
* UI code: `src/__PACKAGE_NAME__/ui/`
* Domain data: `src/__PACKAGE_NAME__/models/`
* App services: `src/__PACKAGE_NAME__/services/`
* Tests: `tests/`

## Commands

```powershell
uv sync --dev
uv run python -m __PACKAGE_NAME__
.\scripts\check.ps1
.\scripts\fix.ps1
```

Keep Qt object creation inside the UI layer. Tests should prefer import and model/service checks unless a task explicitly needs a live window.
