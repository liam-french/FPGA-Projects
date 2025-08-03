`include "../../components/uart.sv"

module uart_loopback_top (
    input  logic clk_i,
    input  logic serial_i,

    output logic serial_o
);
    parameter int CCS_PER_BIT    = 217;

    logic       valid;
    logic [7:0] rx_byte;

    uart_rx #(
        .CCS_PER_BIT(CCS_PER_BIT)
    ) uut_rx (
        .clk_i(clk_i),
        .rx_data_i(serial_i),
        .rx_byte_o(rx_byte),
        .rx_valid_o(valid)
    );

    uart_tx #(
        .CCS_PER_BIT(CCS_PER_BIT)
    ) uut_tx (
        .clk_i(clk_i),
        .tx_byte_i(rx_byte),
        .tx_valid_i(valid),
        .tx_data_o(serial_o),
        .tx_done_o()
    );
endmodule
