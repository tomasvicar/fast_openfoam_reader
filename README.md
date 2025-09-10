# fastofreader

Fast readers for OpenFOAM mesh files implemented in Cython. Currently supports:

- faces: reads integer index groups from OpenFOAM `faces` files
- points: reads triplets of floats from OpenFOAM `points` files
- boundary: reads boundary metadata (nFaces, startFace) from OpenFOAM `boundary` files

Designed to be simple, dependency-free, and fast.

Author: Tomas Vicar <tomasvicar@gmail.com>

## Installation

For development (editable):

```bash
pip install -e .
```

This builds the Cython extension once and links it in editable mode.

## Usage

```python
from fastofreader import (
	read_faces,
	read_points,
	read_faces_from_text,
	read_points_from_text,
	read_boundary,
)

# Faces from file
faces = read_faces("faces_test_file")
print(len(faces), faces[0][:4])

# Points from file
pts = read_points("points_test_file")
print(len(pts), pts[0])

# Boundary file
bounds = read_boundary("boundary_test_file")
print(list(bounds.items())[:1])

# In-memory variants
faces2 = read_faces_from_text("(1 2 3) (4, 5, 6)")
pts2 = read_points_from_text("(0 0 0) (1e-5 0 0)")
```

## API

- `read_faces(path: str) -> list[list[int]]`
	- Reads all integer groups enclosed in parentheses from a file. Returns a list of groups.
- `read_faces_from_text(text: str) -> list[list[int]]`
	- Same as above but takes a string input.
- `read_points(path: str) -> list[list[float]]`
	- Reads point coordinates as triplets `(x y z)` from a file. Returns a list of `[x, y, z]`.
- `read_points_from_text(text: str) -> list[list[float]]`
	- Same as above but takes a string input.
- `read_boundary(path: str) -> dict[str, dict[str, int]]`
	- Parses OpenFOAM boundary file into `{name: {"nFaces": int, "startFace": int}}`.

Notes:
- Parsers ignore the OpenFOAM header and the outer count/parenthesis wrapper.
- Faces parser accepts separators as whitespace, commas, or semicolons.

## Performance tips

- Prefer file-based functions (`read_faces`, `read_points`) to avoid extra encoding/decoding.
- Use CPython 3.10+ for best performance.

## Development

Requirements are declared in `pyproject.toml` and built via setuptools. Common tasks:

```bash
# Editable install
python -m pip install -e .

# Run tests
pytest -q
```

## License

MIT

## Instalace (vývoj)
```bash
pip install -e .
