# Multi-stage build for Cython project (WSL2 friendly)
FROM python:3.11-slim AS build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY pyproject.toml README.md MANIFEST.in ./
COPY src ./src

# Build wheel
RUN pip install --upgrade pip build && python -m build --wheel

FROM python:3.11-slim AS runtime
WORKDIR /app
COPY --from=build /app/dist/*.whl ./
RUN pip install --no-cache-dir *.whl && rm -f *.whl

# Example test run (can be overridden)
CMD ["python", "-c", "from fast_openfoam_reader import fast_sum; print(fast_sum([1,2,3]))"]
