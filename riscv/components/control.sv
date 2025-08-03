module control(
        input logic [31:0] instruction_i,
        output logic MemRead, MemWrite, MemtoReg, Branch, ALUSrc, RegWrite,
        output logic [1:0] ALUOp
    );
    logic [6:0] opcode;

    always_comb begin
        opcode = instruction_i[6:0];
    end

    always_comb begin
        case(opcode)
            7'b0110011: begin // R-Type
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b10;
            end
            7'b0000011: begin // Load, different sizes come from funct3 (lb, lh, lw, lbu, lhu)
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
            end
            7'b0100011: begin // Store, sb, sh, sw comes from funct3
                ALUSrc = 1;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp = 2'b00;
            end
            7'b0010011: begin // I-Type (addi, slti, sltiu, xori, ori, andi)
                ALUSrc = 1;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b11;
            end
            7'b1100011: begin // SB-type
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 2'b01;
            end
            default: begin
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
            end
        endcase
    end
endmodule
