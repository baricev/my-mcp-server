#!/bin/bash

# Script to create a new Python project using uv
# Usage: ./uv-new-project.sh <project_name> [--name <package_name>] [--app]

# NOTE: uv init creates the following structure and files:
# ❯ uv init --python 3.10 --name fizz
# Initialized project `fizz`
# ~/testing/foo (main)
#
# ❯ ll
# total 32
# drwxr-xr-x@ 8 v  staff   256B Jul  8 14:47 ../
# -rw-r--r--@ 1 v  staff    82B Jul  8 14:48 main.py
# -rw-r--r--@ 1 v  staff   150B Jul  8 14:48 pyproject.toml
# drwxr-xr-x@ 9 v  staff   288B Jul  8 14:48 .git/
# -rw-r--r--@ 1 v  staff   109B Jul  8 14:48 .gitignore
# -rw-r--r--@ 1 v  staff     5B Jul  8 14:48 .python-version
# -rw-r--r--@ 1 v  staff     0B Jul  8 14:48 README.md
# drwxr-xr-x@ 8 v  staff   256B Jul  8 14:48 ./
# ~/testing/foo (main)
#
# ❯ cat pyproject.toml
# [project]
# name = "fizz"
# version = "0.1.0"
# description = "Add your description here"
# readme = "README.md"
# requires-python = ">=3.10"
# dependencies = []



set -e

# Function to display usage
usage() {
    echo "Usage: $0 <project_name> [--name <package_name>] [--app]"
    echo "Options:"
    echo "  --name <package_name>  Specify custom package name (default: project_name with underscores)"
    echo "  --app                  Create as application (no package directory)"
    echo "Examples:"
    echo "  $0 my-mcp-server --name my_mcp_server"
    echo "  $0 my-cli-tool --app"
    exit 1
}

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    usage
fi

PROJECT_NAME="$1"
PACKAGE_NAME=""
APP_MODE=false

# Parse command line arguments
shift
while [[ $# -gt 0 ]]; do
    case $1 in
        --name)
            PACKAGE_NAME="$2"
            shift 2
            ;;
        --app)
            APP_MODE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Set default package name if not provided (replace hyphens with underscores)
if [[ -z "$PACKAGE_NAME" ]]; then
    PACKAGE_NAME=$(echo "$PROJECT_NAME" | sed 's/-/_/g')
fi

# Validate project name
if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: Project name cannot be empty"
    exit 1
fi

# Check if directory already exists
if [[ -d "$PROJECT_NAME" ]]; then
    echo "Error: Directory '$PROJECT_NAME' already exists"
    exit 1
fi

echo "Creating new Python project: $PROJECT_NAME"
if [[ "$APP_MODE" == true ]]; then
    echo "Mode: Application"
else
    echo "Package name: $PACKAGE_NAME"
fi

# Create project directory and initialize with uv
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Initialize with uv
if [[ "$APP_MODE" == true ]]; then
    uv init --app --python 3.10
else
    uv init --python 3.10 --name "$PROJECT_NAME"

    # Remove example file and create proper package structure
    rm -f hello.py
    mkdir -p "$PACKAGE_NAME"
    touch "$PACKAGE_NAME/__init__.py"
fi

# Create tests directory
mkdir -p tests
touch tests/__init__.py

# Create pyproject.toml
if [[ "$APP_MODE" == true ]]; then
    # Application mode pyproject.toml
    cat > pyproject.toml << EOF
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.10"
dependencies = [
    # Your runtime dependencies go here
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.uv]
dev-dependencies = [
    "pyink>=24.0.0",
    "ruff>=0.5.0",
    "mypy>=1.10.0",
    "pre-commit>=3.7.0",
    "pytest>=8.2.0",
    "pytest-cov>=5.0.0",
]

# Tool configurations
[tool.pyink]
line-length = 88
target-version = ['py310']
pyink-indentation = 2
pyink-use-majority-quotes = true

[tool.ruff]
line-length = 88
indent-width = 2
target-version = "py310"


[tool.ruff.lint]
select = [
    "E",    # pycodestyle errors
    "W",    # pycodestyle warnings
    "F",    # pyflakes
    "I",    # isort
    "B",    # flake8-bugbear
    "C4",   # flake8-comprehensions
    "UP",   # pyupgrade
]

[tool.ruff.format]
indent-style = "space"
quote-style = "double"

[tool.mypy]
python_version = "3.10"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "--cov --cov-report=term-missing"
EOF
else
    # Library mode pyproject.toml
    cat > pyproject.toml << EOF
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.10"
dependencies = [
    # Your runtime dependencies go here
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

# Explicitly tell hatchling where the package is
[tool.hatch.build.targets.wheel]
packages = ["$PACKAGE_NAME"]

[tool.uv]
dev-dependencies = [
    "pyink>=24.0.0",
    "ruff>=0.5.0",
    "mypy>=1.10.0",
    "pre-commit>=3.7.0",
    "pytest>=8.2.0",
    "pytest-cov>=5.0.0",
]

# Tool configurations
[tool.pyink]
line-length = 88
target-version = ['py310']
pyink-indentation = 2
pyink-use-majority-quotes = true

[tool.ruff]
line-length = 88
indent-width = 2
target-version = "py310"


[tool.ruff.lint]
select = [
    "E",    # pycodestyle errors
    "W",    # pycodestyle warnings
    "F",    # pyflakes
    "I",    # isort
    "B",    # flake8-bugbear
    "C4",   # flake8-comprehensions
    "UP",   # pyupgrade
]

[tool.ruff.format]
indent-style = "space"
quote-style = "double"

[tool.mypy]
python_version = "3.10"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "--cov=$PACKAGE_NAME --cov-report=term-missing"
EOF
fi

# Create README.md
cat > README.md << EOF
## $PROJECT_NAME

### Description

Add your project description here.

### Installation

\`\`\`bash
pip install $PROJECT_NAME
\`\`\`

## Usage

EOF

if [[ "$APP_MODE" == true ]]; then
    cat >> README.md << EOF
\`\`\`bash
# Run the application
uv run main.py
\`\`\`
EOF
else
    cat >> README.md << EOF
\`\`\`python
import $PACKAGE_NAME
\`\`\`
EOF
fi

cat >> README.md << EOF

## Development

\`\`\`bash
# Install dependencies
uv sync

# Run tests
uv run pytest

# Format code
uv run pyink .

# Lint code
uv run ruff check .

# Type check
uv run mypy .
\`\`\`
EOF

# Create package __init__.py with version
if [[ "$APP_MODE" == false ]]; then
    cat > "$PACKAGE_NAME/__init__.py" << 'EOF'
"""Main package."""

__version__ = "0.1.0"
EOF
fi

# Create basic test file
if [[ "$APP_MODE" == true ]]; then
    cat > tests/test_main.py << EOF
"""Tests for main module."""

import pytest
from pathlib import Path


def test_main_exists() -> None:
    """Test that main.py exists."""
    main_file = Path("main.py")
    assert main_file.exists()
EOF
else
    cat > "tests/test_${PACKAGE_NAME}.py" << EOF
"""Tests for $PACKAGE_NAME."""

import pytest
from $PACKAGE_NAME import __version__


def test_version() -> None:
    """Test version is set."""
    assert __version__ == "0.1.0"
EOF
fi

# Optionally patch the main.py file so that it passes the mypy check
# or simply delete it
#
rm main.py



# Create .pre-commit-config.yaml
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files

  - repo: https://github.com/google/pyink
    rev: 24.3.0
    hooks:
      - id: pyink

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.5.0
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.10.0
    hooks:
      - id: mypy
        # Add specific type stubs as needed, e.g.:
        # additional_dependencies: [types-requests, types-click]
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Virtual environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
EOF

echo ""
echo "✅ Successfully created project structure:"
echo "📁 $PROJECT_NAME/"
echo "├── 📄 README.md"
echo "├── ⚙️  pyproject.toml"
echo "├── 🚫 .gitignore"
echo "├── 🔧 .pre-commit-config.yaml"

if [[ "$APP_MODE" == true ]]; then
    echo "├── 🐍 main.py"
else
    echo "├── 📁 $PACKAGE_NAME/"
    echo "│   └── 🐍 __init__.py"
fi

echo "└── 📁 tests/"
echo "    ├── 🐍 __init__.py"

if [[ "$APP_MODE" == true ]]; then
    echo "    └── 🧪 test_main.py"
else
    echo "    └── 🧪 test_${PACKAGE_NAME}.py"
fi

echo ""
echo "Next steps:"
echo "1. cd $PROJECT_NAME"
echo "2. uv sync"
echo "3. uv run pre-commit install"
echo "4. Start coding! 🚀"
echo ""
echo "Running all steps..."
echo ""

# cd $PROJECT_NAME
uv sync
uv run pre-commit install



echo "Available commands:"
echo "• uv run pytest          # Run tests"
echo "• uv run pyink .         # Format code"
echo "• uv run ruff check .    # Lint code"
echo "• uv run mypy .          # Type check"
echo ""
echo "Running all commands..."
echo ""


uv run pytest
uv run pyink .
uv run ruff check . --fix
uv run mypy .
