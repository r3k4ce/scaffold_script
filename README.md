# new-project

`new-project.ps1` scaffolds local project starters in the current directory.

```powershell
.\new-project.ps1 -Profile base
.\new-project.ps1 -Profile desktop
.\new-project.ps1 -Profile web
.\new-project.ps1 -Profile game
```

Profiles:

* `base`: uv-managed Python package.
* `desktop`: base profile plus PySide6 starter folders and a runnable window.
* `web`: FastAPI backend plus Vite React TypeScript frontend.
* `game`: FastAPI backend plus Vite TypeScript frontend with Phaser.
