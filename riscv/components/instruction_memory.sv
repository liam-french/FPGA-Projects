module instruction_memory #(
    parameter int ADDR_WIDTH = 8,
    parameter int INSTRUCTION_WIDTH = 32
) (
    input logic  [INSTRUCTION_WIDTH-1:0] read_addr,
    output logic [INSTRUCTION_WIDTH-1:0] instruction
    );
    logic [INSTRUCTION_WIDTH-1:0] instruction_mem [1 << ADDR_WIDTH];
    initial begin
        $display("Loading instructions from instructions.mem");
        $readmemh("C:\\Users\\liamr\\projects\\FPGA\\riscv\\instructions.mem", instruction_mem);
        for (int i = 0; i < 8; i++) begin
            $display("Instruction_mem[%0d] = %h", i, instruction_mem[i]);
        end
    end
    always_comb begin
        // Convert from byte address to instruction index
        assert (read_addr[1:0] == 2'b00)
        else $error("Misaligned instruction access: %h", read_addr);
        instruction = instruction_mem[read_addr[ADDR_WIDTH-1:2]];
    end
endmodule
