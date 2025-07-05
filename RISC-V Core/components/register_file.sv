module register_file #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 5
)(
    input logic clk, reset,
    // Addresses, source and destination
    input logic [ADDR_WIDTH-1 : 0] rs1_addr, rs2_addr, rd_addr,
    input logic [DATA_WIDTH-1 : 0] rd_data,
    input logic wr_en,
    output logic [DATA_WIDTH-1 : 0] rs1_data, rs2_data
);
    logic [DATA_WIDTH-1 : 0] registers [1<<ADDR_WIDTH];
    assign rs1_data = (rs1_addr == '0) ? '0 : registers[rs1_addr];
    assign rs2_data = (rs2_addr == '0) ? '0 : registers[rs2_addr];

    always_ff @(posedge clk) begin
        if (reset) begin
            foreach (registers[i]) registers[i] <= '0;
        end else if (wr_en && (rd_addr != '0)) begin
            registers[rd_addr] <= rd_data;
        end
    end
endmodule
