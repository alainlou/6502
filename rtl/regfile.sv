`include "types.sv"

import types::*;

module regfile
(
    input wire clk,
    input wire [15:0] next_pc,
    input wire [7:0] alu_hold_reg,
    input wire wr_enable,
    input wire [1:0] reg_dest,
    output reg [7:0] acc_reg,
    output reg [7:0] x_reg,
    output reg [7:0] y_reg,
    output reg [15:0] pc,
    output reg [7:0] status_reg
);
    // write reg
    always @(posedge clk) begin
        if (wr_enable) begin
            case (reg_dest)
                X_REG: x_reg <= alu_hold_reg;
                Y_REG: y_reg <= alu_hold_reg;
                default: acc_reg <= alu_hold_reg;
            endcase
        end
    end

    // update pc
    always @(posedge clk) begin
        pc <= next_pc;
    end

endmodule
