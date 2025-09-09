# fast_openfoam_reader

Fast OpenFOAM reader (skeleton) with Cython acceleration example.

## Features
- Modern `pyproject.toml` build (setuptools + Cython)
- Example Cython module: `fastmath.pyx` (`fast_sum`, `fast_inner_product`)
- Basic tests via `pytest`
- Multi-stage Docker build (Python slim)
- Ready for WSL2 + Docker workflow on Windows

## Project Layout
```
pyproject.toml
MANIFEST.in
Dockerfile
src/
  fast_openfoam_reader/
    __init__.py
    fastmath.pyx
    _version.py
tests/
  test_fastmath.py
```

## Quick Start (Local)
1. Create a virtual environment:
   ```powershell
   python -m venv .venv; .\.venv\Scripts\Activate.ps1
   ```
2. Install in editable mode with dev deps:
   ```powershell
   pip install -U pip
   pip install -e .[dev]
   ```
3. Run tests:
   ```powershell
   pytest -q
   ```
4. Use the functions:
   ```powershell
   python - <<'PY'
   from fast_openfoam_reader import fast_sum, fast_inner_product
   print(f"sum= {fast_sum([1,2,3,4])}")
   print(f"dot= {fast_inner_product([1,2,3],[4,5,6])}")
   PY
   ```

## Build Wheel / sdist
```powershell
python -m build
```
Artifacts appear in `dist/`.

## Docker Build (WSL2 recommended)
From project root (where `Dockerfile` is located):
```powershell
# If in Windows PowerShell (Docker Desktop must be running)
docker build -t fast-openfoam-reader:dev .

docker run --rm fast-openfoam-reader:dev
```
Expected output:
```
6.0
```

To run an interactive shell in the container:
```powershell
docker run -it --rm fast-openfoam-reader:dev bash
```

## WSL2 Workflow Tips
- Place repo inside WSL2 filesystem (e.g. `~/code/fast_openfoam_reader`) for speed.
- Use `python3 -m venv .venv && source .venv/bin/activate` inside WSL for Linux-native build.
- On first compile, Cython will generate C code and build extensions; subsequent imports are faster.

## Extending with More Cython Modules
1. Create `src/fast_openfoam_reader/your_module.pyx`.
2. Import it in `__init__.py` (add to `__all__`).
3. Reinstall (editable mode handles rebuild automatically on change) or touch file + re-import.

If you need custom compile directives (e.g., OpenMP) later, you can add a `setup.cfg` or extend `pyproject.toml` with an extension module specification.

## Running Static Checks
```powershell
ruff check .
ruff format --check .
pytest -q
```

## License
MIT