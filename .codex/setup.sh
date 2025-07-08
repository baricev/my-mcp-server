#!/bin/bash
set -e

# Install project dependencies and dev tools
uv sync

# Additional tools required for CI hooks
uv pip install commitizen detect-secrets

# Install project in editable mode (optional)
uv pip install -e .
