module alu
(
    input clk,
    input [7:0] reg_a,
    input [7:0] reg_b,
    input [4:0] op,
    input carry_in,
    input decimal_mode, // BCD mode, ignored for now
    output reg [7:0] hold_reg,
    output reg overflow,
    output reg carry_out,
    output reg half_carry // only used in BCD, ignored for now
);

    // 6502 ALU uses 1-hot encoding
    localparam SUM=5'b10000, AND=5'b01000, OR=5'b00100, EOR=5'b00010, SR=5'b00001;

    always_comb begin
        case (op)
            SUM : begin
                {carry_out, hold_reg} = reg_a + reg_b;
            end
            AND: hold_reg = reg_a & reg_b;
            OR: hold_reg = reg_a | reg_b;
            EOR: hold_reg = reg_a ^ reg_b;
            SR: hold_reg = reg_a << 1;
            // default: // fall through
        endcase
    end

endmodule
