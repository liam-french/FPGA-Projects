module immediate_gen #(parameter int Width = 32)(
    input logic [Width-1:0] instruction,
    output logic [Width-1:0] imm_out
    );
    always_comb begin
        case (instruction[6:0]) // opcode case
            7'b0010011: begin // I-type
                case (instruction[14:12])
                    3'b001, 3'b101: // Shifts
                        imm_out = $signed(instruction[24:20]);
                    default:
                        imm_out = $signed(instruction[31:20]);
                endcase
            end
            7'b0000011: begin // Load Instructions (I-type)
                imm_out = instruction[31:20];
            end
            7'b0100011: begin // S-type
                imm_out = {{20{instruction[31]}}, {instruction[31:25]}, {instruction[11:7]}};
            end
            default
                imm_out = '0;
        endcase
    end
endmodule
