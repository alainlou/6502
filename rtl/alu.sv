module alu
(
    input signed [7:0] reg_a,
    input signed [7:0] reg_b,
    input [4:0] op,
    input carry_in,
    input decimal_mode, // BCD mode, ignored for now
    output reg signed [7:0] hold_reg,
    output reg overflow, // despite the name, asserted for underflow as well
    output reg carry_out,
    output reg half_carry // only used in BCD, ignored for now
);

    // 6502 opcodes use 1-hot encoding
    localparam SUM=5'b10000, AND=5'b01000, OR=5'b00100, EOR=5'b00010, SR=5'b00001;

    always_comb begin
        case (op)
            SUM : begin
                {carry_out, hold_reg} = reg_a + reg_b;
                overflow = (hold_reg[7] && !reg_a[7] && !reg_b[7]) || (!hold_reg[7] && reg_a[7] && reg_b[7]);
            end
            AND: begin
                hold_reg = reg_a & reg_b;
                carry_out = 0;
                overflow = 0;
            end
            OR: begin
                hold_reg = reg_a | reg_b;
                carry_out = 0;
                overflow = 0;
            end
            EOR: begin
                hold_reg = reg_a ^ reg_b;
                carry_out = 0;
                overflow = 0;
            end
            SR: begin
                hold_reg = reg_a >> 1;
                carry_out = 0;
                overflow = 0;
            end
            default: begin
                hold_reg = 8'hFF; // something bad happened
                carry_out = 0;
                overflow = 0;
            end
        endcase
    end

    `ifdef COCOTB_SIM
    initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu);
    #1;
    end
    `endif
endmodule
