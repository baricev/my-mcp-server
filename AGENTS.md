# Repository instructions

This project uses `uv` for dependency management and `pre-commit` for code quality checks.

## Setup

- Install all dependencies with:
  ```bash
  uv sync
  ```
- Install git hooks:
  ```bash
  pre-commit install
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
- Run tests:
  ```bash
  uv run pytest
  ```

For new commits, run the hooks against staged files:
```bash
pre-commit run --files <files>
```
