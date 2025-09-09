from fast_openfoam_reader import fast_sum, fast_inner_product


def test_fast_sum():
    assert fast_sum([1.0, 2.0, 3.0]) == 6.0


def test_fast_inner_product():
    assert fast_inner_product([1.0, 2.0, 3.0], [4.0, 5.0, 6.0]) == 32.0
