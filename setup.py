from __future__ import annotations
from pathlib import Path
from setuptools import setup

try:
    from Cython.Build import cythonize
except ImportError:  # pragma: no cover
    raise RuntimeError("Cython must be installed (build-system.requires) before building this package")

SRC_DIR = Path(__file__).parent / "src" / "fast_openfoam_reader"

extensions = cythonize(
    [str(SRC_DIR / "fastmath.pyx")],
    compiler_directives={
        "language_level": "3",
        "boundscheck": False,
        "wraparound": False,
        "cdivision": True,
        "initializedcheck": False,
    },
)

setup(ext_modules=extensions)
