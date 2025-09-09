import numpy as np
from fastops import sum_of_squares

def test_sum_of_squares_numpy():
    x = np.array([1.0, 2.0, 3.0], dtype=np.float64, order="C")
    assert sum_of_squares(x) == 14.0

def test_noncontiguous_is_handled():
    x = np.arange(6, dtype=np.float64).reshape(2, 3)[:, 1]  # non-contiguous view
    # Your function either copies to contiguous or raises; adapt the expected behavior:
    assert sum_of_squares(x) == np.square(x).sum()
