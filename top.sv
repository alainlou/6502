`include "rtl/cpu.sv"

module top
(
    input FPGA_CLK,
    input UART_RXD,
    output UART_TXD
);
    localparam CODE_MEM_SIZE = 1024;
    reg [7:0] code_mem [CODE_MEM_SIZE-1:0];
    initial begin
        $readmemh("software/code.mem", code_mem);
    end

    // TODO: can use PLL or clock divider to slow this down
    wire sys_clk = FPGA_CLK;

    wire [15:0] addr;
    cpu cpu_inst
    (
        .clk(sys_clk),
        .data(code_mem[addr]),
        .addr(addr)
    );

endmodule
