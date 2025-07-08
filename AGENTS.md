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

For new commits, run the hooks against staged files:
```bash
uv run pre-commit --files <files>
```
Or run the hooks against all staged files:
```bash
uv run pre-commit --all-files
```


## `pipx` installed libraries:

The Codex container comes with a number of pre-installed Python libraries.

```bash
pipx list

venvs are in /root/.local/share/pipx/venvs
apps are exposed on your $PATH at /root/.local/bin
manual pages are exposed at /root/.local/share/man
   package clang-format 20.1.6, installed using Python 3.12.3
    - clang-format
    - clang-format-diff.py
    - git-clang-format
   package clang-tidy 20.1.0, installed using Python 3.12.3
    - clang-tidy
   package cmakelang 0.6.13, installed using Python 3.12.3
    - cmake-annotate
    - cmake-format
    - cmake-genparsers
    - cmake-lint
    - ctest-to
   package cpplint 2.0.2, installed using Python 3.12.3
    - cpplint
   package poetry 2.1.3, installed using Python 3.12.3
    - poetry
   package uv 0.7.13, installed using Python 3.12.3
    - uv
    - uvx
```
