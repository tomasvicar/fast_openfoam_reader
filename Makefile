PYTHON ?= python3
PACKAGE = fast_openfoam_reader
IMAGE = fast-openfoam-reader:dev

.PHONY: help install dev test lint build wheel clean docker-build docker-run

help:
	@grep -E '^[a-zA-Z_-]+:.*?##' Makefile | sed 's/:.*##/\t- /'

install: ## Install package (no dev extras)
	$(PYTHON) -m pip install -U pip
	$(PYTHON) -m pip install .

dev: ## Editable install with dev deps
	$(PYTHON) -m pip install -U pip
	$(PYTHON) -m pip install -e .[dev]

test: ## Run tests
	pytest -q

lint: ## Run ruff + mypy (soft)
	ruff check src tests
	- mypy src/$(PACKAGE)

build: wheel ## Alias for wheel

wheel: ## Build wheel+sdist
	$(PYTHON) -m build

clean: ## Remove build artifacts
	rm -rf build dist *.egg-info .pytest_cache .mypy_cache .ruff_cache
	find src -name "*.c" -delete || true
	find src -name "*.so" -delete || true

docker-build: ## Build docker image
	docker build -t $(IMAGE) .

docker-run: ## Run container
	docker run --rm $(IMAGE)
