# core.pyx
def sum_of_squares(double[:] arr) -> float:
    cdef Py_ssize_t i, n = arr.shape[0]
    cdef double acc = 0.0
    for i in range(n):
        acc += arr[i] * arr[i]
    return acc
