# distutils: language = c
# cython: boundscheck=False, wraparound=False, cdivision=True, initializedcheck=False
"""Example Cython-accelerated math utilities.

Functions
---------
fast_sum(arr: list[float]) -> float
    Sum of floats using a C-level loop.
fast_inner_product(a: list[float], b: list[float]) -> float
    Dot product of two equal-length float lists.
"""
from cython cimport boundscheck, wraparound
cimport cython

@cython.cfunc
@cython.inline
cdef double _fast_sum(double[:] view) noexcept:
    cdef Py_ssize_t i, n = view.shape[0]
    cdef double acc = 0.0
    for i in range(n):
        acc += view[i]
    return acc

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double fast_sum(list arr):
    """Efficient sum of a list of floats.

    Parameters
    ----------
    arr : list[float]
        Python list of numbers.
    """
    cdef Py_ssize_t n = len(arr)
    cdef double[:] view
    # Convert to memoryview (copy to array of doubles)
    cdef double[::1] tmp = [<double>v for v in arr]
    view = tmp
    return _fast_sum(view)

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double fast_inner_product(list a, list b):
    """Dot product of two lists of floats.

    Raises
    ------
    ValueError if lengths differ.
    """
    if len(a) != len(b):
        raise ValueError("Input lists must have the same length")
    cdef Py_ssize_t n = len(a)
    cdef Py_ssize_t i
    cdef double acc = 0.0
    for i in range(n):
        acc += (<double>a[i]) * (<double>b[i])
    return acc
