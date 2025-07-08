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

# Run tests
uv run nox -s tests

# Format code
uv run pyink .

# Lint code
uv run nox -s lint

# Type check
uv run nox -s typecheck

# Run everything
uv run nox
```

### Updating dependencies

After modifying `pyproject.toml` or adding packages with `uv add`, regenerate
`uv.lock`:

```bash
uv lock --upgrade
```
