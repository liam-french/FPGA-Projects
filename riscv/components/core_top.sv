`include "alu.vh"
`timescale 1ns / 1ns

module core_top #(
    parameter int DATA_WIDTH     = 32,
    parameter int ADDR_WIDTH     = 5,
    parameter int REG_ADDR_WIDTH = 5
)(
        input logic clk_i, reset_i
    );

    // --------------------------------------------------
    // SIGNAL DECLARATIONS
    // --------------------------------------------------

    // INSTRUCTION
    logic [DATA_WIDTH-1:0] instruction;
    logic [2:0] funct3;
    logic [6:0] funct7;

    // ADDRESSES
    logic [ADDR_WIDTH-1:0] addr_trimmed;
    logic [ADDR_WIDTH-1:0] instruction_addr_trimmed;
    logic [ADDR_WIDTH-1:0] next_addr_trimmed;

    logic [DATA_WIDTH-1:0] branch_addr, inc_addr;
    logic [DATA_WIDTH-1:0] instruction_addr, next_addr;

    // REGISTERS
    logic [4:0] rs1, rs2, rd;
    logic [DATA_WIDTH-1:0] reg_data1, reg_data2, write_data;

    // ALU
    logic [DATA_WIDTH-1:0] alu_in;
    logic [DATA_WIDTH-1:0] Result;
    logic [DATA_WIDTH-1:0] immediate;
    logic [1:0] ALUOp;
    logic [3:0] ALUCtl;
    logic [4:0] shamt;

    // CONTROL SIGNALS
    logic MemRead, MemWrite, MemtoReg, Branch, ALUSrc, RegWrite, Zero;
    logic [DATA_WIDTH-1:0] data_mem_out;

    // --------------------------------------------------
    // SIGNAL ASSIGNMENTS
    // --------------------------------------------------

    // pad 0s to match DATA_WIDTH
    assign instruction_addr = {
        {(DATA_WIDTH-ADDR_WIDTH){1'b0}}, instruction_addr_trimmed
    };

    // trim addresses to match ADDR_WIDTH
    assign next_addr_trimmed = next_addr[ADDR_WIDTH-1:0];
    assign addr_trimmed      = Result[ADDR_WIDTH-1:0];

    // Instruction fields
    always_comb begin
        rs1    = instruction[19:15];
        rs2    = instruction[24:20];
        rd     = instruction[11:7];
        funct3 = instruction[14:12];
        funct7 = instruction[31:25];
    end

    // --------------------------------------------------
    // MODULE INSTANTIATIONS
    // --------------------------------------------------
    program_counter #(
        .ADDRESS_WIDTH(ADDR_WIDTH)
    ) pc (
        .clk(clk_i),
        .reset(reset_i),
        .next_addr(next_addr_trimmed),
        .instruction_addr(instruction_addr_trimmed)
    );

    instruction_memory imem (
        .read_addr(instruction_addr),
        .instruction(instruction)
    );

    control ctrl (
        .instruction_i(instruction),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp)
    );

    ALUControl alu_ctrl (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .ALUCtl(ALUCtl)
    );

    immediate_gen imm_gen (
        .instruction(instruction),
        .imm_out(immediate)
    );

    register_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(REG_ADDR_WIDTH)
    ) reg_file (
        .clk(clk_i),
        .reset(reset_i),
        .rs1_addr(rs1),
        .rs2_addr(rs2),
        .rd_addr(rd),
        .rd_data(write_data),
        .wr_en(RegWrite),
        .rs1_data(reg_data1),
        .rs2_data(reg_data2)
    );

    alu #(DATA_WIDTH) adder (
        .A_i(instruction_addr),
        .B_i(4), // Increment by 4 for next instruction
        .ctl_i(ALU_ADD),
        .shamt_i(),
        .result_o(inc_addr),
        .zero_o()
    );

    alu #(DATA_WIDTH) branch_adder (
        .A_i(instruction_addr),
        .B_i(immediate),
        .ctl_i(ALU_ADD),
        .shamt_i(),
        .result_o(branch_addr),
        .zero_o()
    );

    mux2x1 #(DATA_WIDTH) pc_mux (
        .select(Branch && Zero),
        .S0(inc_addr),
        .S1(branch_addr),
        .mux_out(next_addr)
    );

    mux2x1 #(DATA_WIDTH) alu_in_mux (
        .select(ALUSrc),
        .S0(reg_data2),
        .S1(immediate),
        .mux_out(alu_in)
    );

    mux2x1 #(5) shift_amount_mux (
        .select(ALUOp[0]),
        .S0(reg_data2[4:0]),
        .S1(instruction[24:20]),
        .mux_out(shamt)
    );

    alu alu (
        .A_i(reg_data1),
        .B_i(alu_in),
        .ctl_i(ALUCtl),
        .shamt_i(shamt),
        .result_o(Result),
        .zero_o(Zero)
    );

    data_memory #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) data_mem (
        .clk(clk_i),
        .write_en(MemWrite),
        .read_en(MemRead),
        .addr(addr_trimmed),
        .write_data(reg_data2),
        .read_data(data_mem_out)
    );

    mux2x1 #(DATA_WIDTH) data_mux (
        .select(MemtoReg),
        .S0(Result),
        .S1(data_mem_out),
        .mux_out(write_data)
    );
endmodule
