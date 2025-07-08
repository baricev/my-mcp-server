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
  uv run pyink .
  ```
- Lint and auto-fix:
  ```bash
  uv run ruff check . --fix
  ```
- Type check:
  ```bash
  uv run mypy .
  ```
- Run tests (in parallel):
  ```bash
  uv run pytest -n auto
  ```
- Bump the project version:
  ```bash
  cz bump
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
