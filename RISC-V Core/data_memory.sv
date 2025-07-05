module data_memory #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 8
)(
    input logic clk, write_en, read_en,
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [31:0] write_data,
    output logic [31:0] read_data
    );

    logic [DATA_WIDTH-1:0] data_mem [2**ADDR_WIDTH];
    always_comb begin
        if (read_en) read_data = data_mem[addr];
        else read_data = '0;
    end
    always_ff @(posedge clk) begin
        if (write_en) data_mem[addr] <= write_data;
    end
endmodule
