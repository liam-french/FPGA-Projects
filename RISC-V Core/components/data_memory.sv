module data_memory #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 8
)(
    input logic clk, write_en, read_en,
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [31:0] write_data,
    output logic [31:0] read_data
    );

    parameter int DEPTH = 2**ADDR_WIDTH;

    // Log writes to a file in sim
    integer log_file;
    initial begin
        log_file = $fopen("memory_write_log.txt", "w");
    end

    logic [DATA_WIDTH-1:0] data_mem [DEPTH];

    always_comb begin
        if (read_en) read_data = data_mem[addr];
        else read_data = '0;
    end
    always_ff @(posedge clk) begin
        if (write_en) data_mem[addr] <= write_data;
        if (log_file) begin
            $fwrite(log_file, "%h:%h\n", addr, write_data);
        end
    end
endmodule
