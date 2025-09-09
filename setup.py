from setuptools import setup, Extension
from Cython.Build import cythonize
import os
import numpy as np  # <-- now safe: build-system ensures NumPy is present

CFLAGS  = os.environ.get("FASTOPS_CFLAGS", "").split()
LDFLAGS = os.environ.get("FASTOPS_LDFLAGS", "").split()

extensions = [
    Extension(
        name="fastops.core",
        sources=["src/fastops/core.pyx"],
        include_dirs=[np.get_include()],              # <-- add headers
        extra_compile_args=CFLAGS + ["-DNPY_NO_DEPRECATED_API=NPY_1_20_API_VERSION"],
        extra_link_args=LDFLAGS,
    )
]

setup(
    ext_modules=cythonize(
        extensions,
        compiler_directives={
            "language_level": "3",
            "boundscheck": False,
            "wraparound": False,
            "initializedcheck": False,
            "nonecheck": False,
            "cdivision": True,
            "embedsignature": True,
            "infer_types": True,
        },
    ),
)
