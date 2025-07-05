`include "alu.vh"

module alu #(parameter int DATA_WIDTH = 32) (
    input [DATA_WIDTH-1:0] A, B,
    input logic [3:0] ALUCtl,
    output logic [31:0] Result,
    output logic Zero
    );
    assign Zero = (Result == 32'b0);
    always @(ALUCtl, A, B) begin
        case(ALUCtl)
            ALU_ADD: Result = A + B;
            ALU_SUB: Result = A - B;
            ALU_AND: Result = A & B;
            ALU_OR:  Result = A | B;
            ALU_XOR: Result = A ^ B;
            ALU_SLT: Result = (A < B) ? 1 : 0;
            default: Result = 0;
        endcase
    end
endmodule
