## my-mcp-server

### Description

Add your project description here.

### Installation

```bash
uv pip install my-mcp-server
```

## Usage

```python
import my_mcp_server
```

## Development

```bash
# Install dependencies
uv sync
uv run pre-commit install

# Format code
uv run nox -s format

# Lint code
uv run nox -s lint

# Type check
uv run nox -s typecheck

# Run tests
uv run nox -s tests

# Run everything
uv run nox
```

### Updating dependencies

After modifying `pyproject.toml` or adding packages with `uv add`, regenerate
`uv.lock`:

```bash
uv lock --upgrade
```
