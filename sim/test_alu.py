import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_add(alu):
    alu.op = 0b10000

    for val1 in range(-128, 128):
        for val2 in range(-128, 128):
            alu.reg_a <= val1
            alu.reg_b <= val2

            await Timer(1, units='ns')

            if -128 <= val1 + val2 < 128:
                assert alu.hold_reg.value.signed_integer == val1 + val2, f"Add result is incorrect: {alu.hold_reg.value.signed_integer} != {val1 + val2}"
                assert not alu.overflow.value, f"Overflow was incorrectly asserted for operands {val1} and {val2}"
            else:
                assert alu.overflow.value, f"Overflow failed to be asserted for operands {val1} and {val2}"
