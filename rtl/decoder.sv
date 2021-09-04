// Cycle 0: decode opcode
// Cycle 1: decode immediate
// Cycle 2: decode rest of stuff and send send stuff through ALU and stuff
// Cycle 3/Cycle 0: regfile grabs ALU output and decode opcode of next instruction
module decoder
(
    input clk,
    input wire [7:0] instr,
    output reg [1:0] alu_op1_sel,
    output reg [1:0] alu_op2_sel,
    output reg [7:0] imm_val
);
    enum {ACC, IMM, ZPG, ABS, IND, X_IDX, Y_IDX, REL, ERR} addr_mode;

    enum {S0, S1, S2} state = S0;

    always_ff @(posedge clk) begin : decoder_output
        case (state)
            S0: begin
                case (instr)
                    8'bxxx01001, 8'hA0, 8'hA2, 8'hC0, 8'hE0:
                        addr_mode <= IMM;
                    default: addr_mode <= ERR;
                endcase
                // also decode alu op
            end
            S1:
                imm_val <= instr;
            S2: begin
               // do nothing for now
            end
        endcase
    end

    always_ff @(posedge clk) begin : decoder_fsm
        case (state)
            S0: state <= S1;
            S1: state <= S2;
            S2: state <= S0;
        endcase
    end
endmodule
