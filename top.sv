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

    ////////////////////////////////////////////////////////////////////////////////
    // Output devices
    ////////////////////////////////////////////////////////////////////////////////

    // Display program counter on 7seg
    svnseg_controller controller_inst
    (
        .clk(FPGA_CLK),
        .num3(pc[15:12]),
        .num2(pc[11:8]),
        .num1(pc[7:4]),
        .num0(pc[3:0]),
        .dig1(SVNSEG_DIG1),
        .dig2(SVNSEG_DIG2),
        .dig3(SVNSEG_DIG3),
        .dig4(SVNSEG_DIG4),
        .seg0(SVNSEG_SEG0),
        .seg1(SVNSEG_SEG1),
        .seg2(SVNSEG_SEG2),
        .seg3(SVNSEG_SEG3),
        .seg4(SVNSEG_SEG4),
        .seg5(SVNSEG_SEG5),
        .seg6(SVNSEG_SEG6),
        .seg7(SVNSEG_SEG7)
    );

    // Display registers on LEDs, use DIP switch to toggle between them
    wire [3:0] leds;
    always_comb begin : leds
        case()
    end
    assign {LED1, LED2, LED3, LED4} = leds;

endmodule
