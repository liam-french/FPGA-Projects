`include "alu.vh"

module alu #(parameter int DATA_WIDTH = 32) (
        input  logic [DATA_WIDTH-1:0] A_i, B_i,
        input  logic [3:0] ctl_i,
        input  logic [4:0] shamt_i,
        output logic [DATA_WIDTH-1:0] result_o,
        output logic zero_o
    );
    assign Zero = (result_o == 32'b0);
    always @(ctl_i, A_i, B_i) begin
        case(ctl_i)
            ALU_ADD: result_o = A_i + B_i;
            ALU_SUB: result_o = A_i - B_i;
            ALU_AND: result_o = A_i & B_i;
            ALU_OR:  result_o = A_i | B_i;
            ALU_XOR: result_o = A_i ^ B_i;
            ALU_SLT: result_o = (A_i < B_i) ? 1 : 0;
            ALU_SLL: result_o = A_i << shamt_i;
            ALU_SRL: result_o = A_i >> shamt_i;
            ALU_SRA: result_o = A_i >>> shamt_i;
            default: result_o = 0;
        endcase
    end
endmodule
