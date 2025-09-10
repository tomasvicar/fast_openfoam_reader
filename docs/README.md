# fastofreader docs

## Quickstart

```python
from fastofreader import read_faces, read_points, read_boundary

faces = read_faces("faces_test_file")
points = read_points("points_test_file")
boundary = read_boundary("boundary_test_file")

print(len(faces), len(points), list(boundary)[:2])
```

## API Reference

- read_faces(path: str) -> list[list[int]]
- read_faces_from_text(text: str) -> list[list[int]]
- read_points(path: str) -> list[list[float]]
- read_points_from_text(text: str) -> list[list[float]]
- read_boundary(path: str) -> dict[str, dict[str, int]]

Behavior:
- Ignores OpenFOAM header blocks.
- Faces: parses integers within any `( ... )` groups.
- Points: parses triplets `(x y z)`; values may be in scientific notation.
- Boundary: returns `{name: {"nFaces": int, "startFace": int}}` for each entry.

## FAQ

- Q: Does it require NumPy?
  - A: No. It is dependency-free at runtime.

- Q: How fast is it?
  - A: It uses Cython with pointer-level parsing; expect significant speedups over pure Python.
