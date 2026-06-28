# AGENTS.md

## Project

This is a Python project managed with `uv`.

* Source code: `src/__PACKAGE_NAME__/`
* Tests: `tests/`
* Primary shell: Windows PowerShell
* Prefer repo scripts over ad hoc commands.

## Instruction Order

Follow instructions in this order:

1. The current user task.
2. This `AGENTS.md`.
3. Existing code, tests, docs, and project patterns.
4. Available skills and tools.

If instructions conflict, preserve user intent and existing behavior. Stop and ask only when the conflict changes behavior, data, security, architecture, dependencies, UX, or workflow.

## Non-Negotiables

You must follow these rules:

* Preserve existing behavior unless the user explicitly asks to change it.
* Keep the change as small as possible.
* Prefer existing code, repo helpers, stdlib, and installed dependencies before adding anything new.
* Do not add broad refactors, new architecture, speculative abstractions, alternate implementations, or future configurability.
* Do not add dependencies unless the task clearly requires them.
* Keep validation, security, data safety, accessibility, and tests intact.
* Preserve unrelated user changes. If local changes conflict with the task, stop and ask.
* If the user asks for a plan, review, opinion, or recommendation, stay read-only unless they explicitly ask for implementation.
* Finish the requested outcome end to end, including the obvious neighboring files and checks needed for it to actually work.

## Skills And Tools

Use available skills and tools when they fit the task. Do not write long explanations about tool availability unless it changes the result.

* **Superpowers**: use for non-trivial features, bugs, refactors, plans, and reviews.
* **Ponytail**: use by default. Minimize code, avoid speculative abstractions, prefer deletion, stdlib, existing helpers, and existing patterns.
* **Context7**: use when current library, SDK, framework, CI, auth, deployment, API, or security docs matter.

If a skill or tool is unavailable, continue with the closest local workflow.

## Before Editing

Do these before changing files:

1. Inspect the relevant files.
2. Search for existing helpers, patterns, and callers before creating new code.
3. Check `git status` and protect unrelated user changes.
4. Clarify only material scope gaps.

Ask focused questions when the goal, success criteria, UX, data shape, behavior boundary, or completion boundary is unclear. Ask 1-3 questions max, use concrete options, and recommend a default.

Do not ask about small reversible code mechanics. Choose the simplest option and record the assumption in the handoff.

## Implementation Workflow

For features, behavior changes, bug fixes, and non-trivial refactors:

1. Write or update one focused test for the requested behavior first.
2. Run the focused test and confirm it fails for the expected reason when feasible.
3. Implement the smallest correct change needed to pass the test.
4. Run the focused test again.
5. Run broader checks listed below when feasible.

Docs, comments, and simple config-only edits may skip the red test step, but still require review and relevant verification.

## Research

Use this order:

1. Inspect local files first.
2. Use `rg`, `fd`, `jq`, and `yq` when available; otherwise use PowerShell or Python stdlib.
3. Use Context7 before relying on current external library/API/framework docs.
4. Use web/docs research only when current external facts matter or the user asks.

Summarize findings. Do not paste long docs, logs, or unrelated search results.

## Commands

Use these commands when relevant:

```powershell
uv sync --dev
uv run pytest
uv run pyright
uv run ruff check .
uv run ruff format --check .
.\scripts\check.ps1
.\scripts\fix.ps1
```

Use `uv add` or `uv add --dev` for dependencies.

## Verification

Before claiming completion:

1. Run the focused check first.
2. Run `.\scripts\check.ps1` when feasible.
3. Read command output and confirm exit codes.
4. If a check is skipped, state exactly why.
5. Do not claim tests pass unless they were run in this turn and passed.

## Security

* Never commit secrets.
* Do not create `.env`.
* Update `.env.example` with placeholder names when new environment variables are required.
* Keep real secret values out of the repo.

## Git

* Do not stage or commit.
* Do not run `git add`, `git commit`, or equivalent commands.
* Read-only Git inspection is allowed: `git status`, `git diff`, `git log`.

## Docs And Memory

Update `README.md` only when setup, commands, usage, config, dependencies, or user-facing behavior changes.

Update `.env.example` when new env vars are required. Never create `.env`.

Update `docs/project-memory.yaml` only after completed implementation for code, behavior, dependency, workflow, structure, or decision changes.

Optional docs are `docs/architecture.md`, `docs/decisions.md`, and `docs/troubleshooting.md`. Create them only when they reduce future confusion.

Do not create docs for obvious code, temporary plans, proposed work, failed attempts, exploratory work, commit messages, or routine details.

Keep `docs/project-memory.yaml` entries compact and machine-readable:

```yaml
time_utc:
time_local:
summary:
changed:
verification:
```

If no docs update is needed, say why in the handoff.

## Final Self-Check

Before the final response, confirm:

* Relevant files were inspected.
* The change stayed within the requested scope.
* Existing behavior was preserved unless explicitly changed.
* Tests/checks were run or skipped with a stated reason.
* Docs and memory were updated only if required.
* The handoff is compact and names files, checks, skipped work, and a suggested commit message.

## Handoff

Keep the final handoff compact. Include only relevant sections:

* Changed: behavior and files touched.
* Verified: commands run and results.
* Skipped: checks not run and why.
* Docs: memory update or why none was needed.
* Commit: suggested Conventional Commit message.

Prefer 12 lines or fewer. Expand only when failures, risks, migrations, or user decisions require it.
Do not include broad explanations, future feature ideas, or unrelated cleanup suggestions.
