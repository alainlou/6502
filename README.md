# 6502

MOS 6502 in verilog!

Plans:
- Build full computer on FPGA board with this, try to run some old games?

---

What I did:
1. First wrote rtl/alu.sv and sim/test_alu.py kinda naivel
   - [ ] clk, decimal_mode (BCD), carry_in, carry_out, half_carry are not being used in alu.sv


What I'm going to do:
1. Try to run a simple add two numbers program
   - Implement decoder and regfile initially for immediate addressing mode, then move on to other addressing modes one by one

---

rtl:
- Contains verilog

sim:
- Contains testbenches

software:
- Uses https://www.masswerk.at/6502/assembler.html
- Contains some small assembly programs
