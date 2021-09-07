`include "alu.sv"
`include "decoder.sv"
`include "regfile.sv"

`include "svnseg_controller.sv"

module cpu
(
    input clk,
    input [7:0] data,
    output [15:0] addr
);

    // Register file
    wire [7:0] acc_reg, x_reg, y_reg;
    wire [15:0] pc;
    wire [7:0] status_reg;
    regfile regfile_inst
    (
        .clk(clk),
        .acc_reg(acc_reg),
        .x_reg(x_reg),
        .y_reg(y_reg),
        .pc(pc),
        .status_reg(status_reg)
    );

    // Decoder
    wire [1:0] alu_op1_sel, alu_op2_sel;
    wire [7:0] imm_val;
    decoder decoder_inst
    (
        .instr(data),
        .alu_op1_sel(alu_op1_sel),
        .alu_op2_sel(alu_op2_sel),
        .imm_val(imm_val)
    );

    wire signed [7:0] alu_op1, alu_op2;
    wire signed [4:0] alu_op;
    wire carry_in, decimal_mode;
    wire [7:0] hold_reg;
    wire overflow, carry_out, half_carry;

    // alu op1 and op2 muxes
    // always_comb begin : alu_op_muxes

    // end

    alu alu_inst
    (
        .reg_a(alu_op1),
        .reg_b(alu_op2),
        .op(alu_op),
        .carry_in(carry_in),
        .decimal_mode(decimal_mode),
        .hold_reg(hold_reg),
        .overflow(overflow),
        .carry_out(carry_in), // TODO: figure out CLC instruction stuff
        .half_carry(half_carry)
    );
endmodule
