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
            2'b10: begin
                case(funct3)
                    3'b000: ALUCtl = (funct7[5] == 1'b1) ? ALU_SUB : ALU_ADD;
                    3'b000: ALUCtl = ALU_ADD;
                    3'b001: ALUCtl = ALU_SLL;
                    3'b010: ALUCtl = ALU_SLT;
                    3'b011: ALUCtl = ALU_SLT;
                    3'b100: ALUCtl = ALU_XOR;
                    3'b101: ALUCtl = (funct7[5] == 1'b1) ? ALU_SRL : ALU_SRA;
                    3'b110: ALUCtl = ALU_OR;
                    3'b111: ALUCtl = ALU_AND;
                    default: ALUCtl = 15;
                endcase
            end
            2'b11: begin
                case(funct3)
                    3'b000: ALUCtl = ALU_ADD;
                    3'b001: ALUCtl = ALU_SLL;
                    3'b010: ALUCtl = ALU_SLT;
                    3'b011: ALUCtl = ALU_SLT;
                    3'b100: ALUCtl = ALU_XOR;
                    3'b101: ALUCtl = (funct7[5] == 1'b1) ? ALU_SRL : ALU_SRA;
                    3'b110: ALUCtl = ALU_OR;
                    3'b111: ALUCtl = ALU_AND;
                    default: ALUCtl = 15;
                endcase
            end
            default: begin
                ALUCtl = 15;
            end
        endcase
    end
endmodule
