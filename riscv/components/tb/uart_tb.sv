`timescale 1ns/10ps
 
`include "../uart.sv"

// UART TB Modified from https://nandland.com/uart-serial-port-module/

module uart_tb ();
 
    parameter int CLOCK_PERIOD_NS = 40;
    parameter int CLKS_PER_BIT    = 217;
    parameter int BIT_PERIOD      = (CLOCK_PERIOD_NS - 1) * CLKS_PER_BIT;
    
    logic       Clock = 0;
    logic       Tx_DV = 0;
    logic       Rx_Serial;
    logic       Tx_Done;
    logic [7:0] Tx_Byte = 0;
    logic [7:0] Rx_Byte;   

    uart_rx #(
        .CCS_PER_BIT(CLKS_PER_BIT)
    ) uut_rx (
        .clk_i(r_Clock),
        .rx_data_i(Rx_Serial),
        .rx_byte_o(Rx_Byte),
        .rx_valid_o()
    );

    uart_tx #(
        .CCS_PER_BIT(CLKS_PER_BIT)
    ) uut_tx (
        .clk_i(r_Clock),
        .tx_byte_i(r_Tx_Byte),
        .tx_valid_i(r_Tx_DV),
        .tx_data_o(Rx_Serial),
        .tx_done_o(w_Tx_Done)
    );

    always
        #(CLOCK_PERIOD_NS/2) Clock <= !Clock;
    initial
        begin
            @(posedge r_Clock);
            @(posedge r_Clock);
            Tx_DV <= 1'b1;
            Tx_Byte <= 8'hAB;
            @(posedge r_Clock);
            Tx_DV <= 1'b0;
            @(posedge w_Tx_Done);

            if (Rx_Byte == 8'hAB) begin
                $display("Test Passed - Correct Byte Received");
                $finish;
            end
            else begin
                $display("Test Failed - Incorrect Byte Received");
            end
        end
endmodule
