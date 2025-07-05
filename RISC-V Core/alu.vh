`ifndef TYPES_PKG_VH
`define TYPES_PKG_VH

typedef enum logic [3:0] {
    ALU_ADD = 4'b0010,
    ALU_SUB = 4'b0110,
    ALU_AND = 4'b0000,
    ALU_OR  = 4'b0001,
    ALU_XOR = 4'b0011,
    ALU_SLT = 4'b0111
} alu_ctl_t;

`endif
