module program_counter #(
    parameter int ADDRESS_WIDTH = 8
)(
    input logic clk, reset,
    input logic [ADDRESS_WIDTH-1:0] next_addr,
    output logic [ADDRESS_WIDTH-1:0] instruction_addr
    );
    always_ff @(posedge clk or posedge reset) begin
        if (reset) instruction_addr <= '0;
        else instruction_addr <= next_addr;
    end
endmodule
