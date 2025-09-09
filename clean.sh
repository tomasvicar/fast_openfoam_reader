#!/usr/bin/env bash
# Clean Python/Cython build artefacts and caches

set -euo pipefail

echo "Cleaning build artifacts..."

# Python cache/bytecode
find . -type d -name "__pycache__" -exec rm -rf {} +
find . -type f -name "*.py[co]" -delete
find . -type f -name "*~" -delete

# Cython / compiled extensions
find . -type f -name "*.c" -delete
find . -type f -name "*.cpp" -delete
find . -type f -name "*.so" -delete
find . -type f -name "*.pyd" -delete
find . -type f -name "*.dll" -delete
find . -type f -name "*.dylib" -delete

# Build system directories
rm -rf build/
rm -rf dist/
rm -rf *.egg-info/
rm -rf .eggs/

# Testing/coverage
rm -rf .pytest_cache/
rm -rf .coverage
rm -rf htmlcov/
rm -rf .tox/
rm -rf .nox/
rm -rf .mypy_cache/
rm -rf .ruff_cache/
rm -rf .benchmarks/

# Devcontainer / editor
rm -rf .vscode/.ropeproject
rm -rf .idea/

echo "Done."
