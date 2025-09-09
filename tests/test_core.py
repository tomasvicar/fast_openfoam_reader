from array import array
from fastops import sum_of_squares

def test_sum_of_squares_list():
    data = [1.0, 2.0, 3.0]
    # převést na array('d') = double precision
    arr = array("d", data)
    result = sum_of_squares(arr)
    assert result == 1.0 + 4.0 + 9.0

def test_sum_of_squares_memoryview():
    arr = array("d", [0.5, 1.5, 2.5])
    mv = memoryview(arr)
    result = sum_of_squares(mv)
    assert abs(result - (0.25 + 2.25 + 6.25)) < 1e-12
