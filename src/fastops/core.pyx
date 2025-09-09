# distutils: language = c
# cython: boundscheck=False, wraparound=False, nonecheck=False, initializedcheck=False
# cython: infer_types=True, cdivision=True, embedsignature=True

cdef inline double _square(double x) nogil:
    return x * x

def sum_of_squares(double[:] arr) -> float:
    """
    Compute sum of squares over a 1D buffer-compatible array.
    Works with objects supporting the buffer protocol,
    e.g. array.array("d") or Python's built-in memoryview.
    """
    cdef Py_ssize_t i, n = arr.shape[0]
    cdef double acc = 0.0
    for i in range(n):
        acc += _square(arr[i])
    return acc
