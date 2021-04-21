from cocotb.regression import TestFactory
from cocotb.triggers import Timer

async def test_op(dut, operation):
    dut.op = operation[1]
    check_func = operation[0]

    for val1 in range(-128, 128):
        for val2 in range(-128, 128):
            dut.reg_a <= val1
            dut.reg_b <= val2

            await Timer(1, units='ns')

            check_func(val1, val2, dut.hold_reg.value.signed_integer, dut.overflow.value)

def check_add(val1, val2, actual, overflow):
    if -128 <= val1 + val2 < 128:
        assert actual == val1 + val2, f"Add result is incorrect: {actual} != {val1 + val2}"
        assert not overflow, f"Overflow was incorrectly asserted for operands {val1} and {val2}"
    else:
        assert overflow, f"Overflow failed to be asserted for operands {val1} and {val2}"

def check_and(val1, val2, actual, overflow):
    assert actual == val1 & val2, f"AND result is incorrect: {actual} != {val1 & val2}"

def check_or(val1, val2, actual, overflow):
    assert actual == val1 | val2, f"OR result is incorrect: {actual} != {val1 | val2}"

def check_eor(val1, val2, actual, overflow):
    assert actual == val1 ^ val2, f"EOR result is incorrect: {actual} != {val1 | val2}"

def check_sr(val1, val2, actual, overflow):
    expected = val1 >> 1 if val1 >= 0 else (val1 + 0b100000000) >> 1 # logic shift right
    assert actual == expected, f"SR result is incorrect: {actual} != {expected}"

factory = TestFactory(test_op)
factory.add_option('operation', [(check_add, 0b10000), (check_and, 0b01000), (check_or, 0b00100), (check_eor, 0b00010), (check_sr, 0b00001)])
factory.generate_tests()

