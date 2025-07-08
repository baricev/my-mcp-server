# Repository instructions

This project uses `uv` for dependency management, `pre-commit` for code quality checks, and `commitizen` for semantic versioning.

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
- Run tests (in parallel):
  ```bash
  uv run nox -s tests
  ```
  or use
  
  ```
  uv run pytest -n auto
  ```
- Bump the project version:
  ```bash
  cz bump
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

## Commit messages

Commit messages **must** follow the Conventional Commits specification. Use
`commitizen` to craft your messages:

```bash
uv run cz commit  # or simply `cz c`
```

The `commitizen` pre-commit hook validates commit messages during the
`commit-msg` stage.


## Note

The Codex container includes many common utilities installed via `pipx`. Run `pipx list` if you need to see the available tools.
