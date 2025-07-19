`include "alu.vh"

module ALUControl (
        input logic [1:0] ALUOp,
        input logic [2:0] funct3,
        input logic [6:0] funct7,
        output logic [3:0] ALUCtl
    );
    always_comb begin
        case(ALUOp)
            2'b00: ALUCtl = ALU_ADD;
            2'b01: ALUCtl = ALU_SUB;            
            2'b10, 2'b11: begin
                case(funct3)
                    0: ALUCtl = (funct7 == 7'b0100000) ? ALU_SUB : ALU_ADD;
                    3'b111: ALUCtl = ALU_AND;
                    3'b110: ALUCtl = ALU_OR;
                    default: ALUCtl = 15; // NOP or invalid operation
                endcase
            end
            default: begin
                ALUCtl = 15; // NOP or invalid operation
            end
        endcase
    end
endmodule
