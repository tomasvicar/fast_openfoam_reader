import numpy as np
from fastops import sum_of_squares

arr = np.array([1.0, 2.0, 3.0], dtype=np.float64)
print("sum_of_squares:", sum_of_squares(arr))  # prints 14.0