# Repository instructions

This project uses `uv` for dependency management and `pre-commit` for code quality checks.

## Setup

- Install all dependencies with:
  ```bash
  uv sync
  ```
- Install git hooks:
  ```bash
  uv run pre-commit install
  ```

## Development workflow

- Format code:
  ```bash
  uv run nox -s format
  ```
- Lint and auto-fix:
  ```bash
  uv run nox -s lint
  ```
- Type check:
  ```bash
  uv run nox -s typecheck
  ```
- Run tests:
  ```bash
  uv run nox -s tests
  ```

Run a specific session with `uv run nox -s <session>` or run all sessions with `uv run nox`.

After updating dependencies, regenerate `uv.lock` with:
```bash
uv lock --upgrade
```

For new commits, run the hooks against staged files:
```bash
uv run pre-commit --files <files>
```
Or run the hooks against all staged files:
```bash
uv run pre-commit --all-files
```


## Note

The Codex container includes many common utilities installed via `pipx`. Run `pipx list` if you need to see the available tools.
