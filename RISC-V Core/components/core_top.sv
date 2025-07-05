`include "alu.vh"
`timescale 1ns / 1ns

module core_top #(
    parameter int DATA_WIDTH = 32,
    parameter int DATA_ADDR_WIDTH = 5,
    parameter int INSTRUCTION_ADDR_WIDTH = 5,
    parameter int REG_ADDR_WIDTH = 5
)(
        input logic clk_i, reset_i
    );


    // Internal signals
    logic [DATA_WIDTH-1:0] instruction_addr, next_addr;
    logic [INSTRUCTION_ADDR_WIDTH-1:0] instruction_addr_trimmed, next_addr_trimmed;
    logic [DATA_WIDTH-1:0] instruction;
    logic [DATA_WIDTH-1:0] alu_in;
    logic [DATA_WIDTH-1:0] branch_addr, inc_addr;
    logic [DATA_WIDTH-1:0] Result;
    logic [DATA_WIDTH-1:0] data_mem_out;
    logic [DATA_ADDR_WIDTH-1:0] addr_trimmed;
    logic [4:0] rs1, rs2, rd;
    logic [DATA_WIDTH-1:0] reg_data1, reg_data2, write_data;

    logic [3:0] ALUCtl;
    logic MemRead, MemWrite, MemtoReg, Branch, ALUSrc, RegWrite, Zero;
    logic [1:0] ALUOp;

    // Instantiate the program counter
    assign next_addr_trimmed = next_addr[INSTRUCTION_ADDR_WIDTH-1:0];
    // Expand instruction_addr_trimmed to DATA_WIDTH wide by zero-extending
    assign instruction_addr = {
        {(DATA_WIDTH-INSTRUCTION_ADDR_WIDTH){1'b0}}, instruction_addr_trimmed
    };
    // Trim alu result to match address width
    assign addr_trimmed = Result[DATA_ADDR_WIDTH-1:0];

    program_counter #(
        .ADDRESS_WIDTH(INSTRUCTION_ADDR_WIDTH)
    ) pc (
        .clk(clk_i),
        .reset(reset_i),
        .next_addr(next_addr_trimmed),
        .instruction_addr(instruction_addr_trimmed)
    );

    // Instantiate the instruction memory
    instruction_memory imem (
        .read_addr(instruction_addr),
        .instruction(instruction)
    );

    // Instantiate the control unit
    control ctrl (
        .instruction(instruction),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp)
    );

    // ALU Control
    ALUControl alu_ctrl (
        .ALUOp(ALUOp),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .ALUCtl(ALUCtl)
    );

    // Immediate Generator
    logic [DATA_WIDTH-1:0] immediate;
    immediate_gen imm_gen (
        .instruction(instruction),
        .imm_out(immediate)
    );

    // Register File
    always_comb begin
        rs1 = instruction[19:15]; // rs1 field from instruction
        rs2 = instruction[24:20]; // rs2 field from instruction
        rd  = instruction[11:7];  // rd field from instruction
    end

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

    // Adders
    alu #(DATA_WIDTH) adder (
        .A(instruction_addr),
        .B(4), // Increment by 4 for next instruction
        .ALUCtl(ALU_ADD),
        .Result(inc_addr),
        .Zero()
    );

    alu #(DATA_WIDTH) branch_adder (
        .A(instruction_addr),
        .B(immediate),
        .ALUCtl(ALU_ADD),
        .Result(branch_addr),
        .Zero()
    );

    // PC Address Mux
    mux2x1 #(DATA_WIDTH) pc_mux (
        .select(Branch && Zero), // Branch if zero
        .S0(inc_addr), // Next instruction address
        .S1(branch_addr), // Branch target address
        .mux_out(next_addr)
    );

    mux2x1 #(DATA_WIDTH) alu_in_mux (
        .select(ALUSrc),
        .S0(reg_data2),
        .S1(immediate),
        .mux_out(alu_in)
    );

    // ALU
    alu alu (
        .A(reg_data1),
        .B(alu_in),
        .ALUCtl(ALUCtl),
        .Result(Result),
        .Zero(Zero)
    );

    // Data Memory
    data_memory #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(DATA_ADDR_WIDTH)
    ) data_mem (
        .clk(clk_i),
        .write_en(MemWrite),
        .read_en(MemRead),
        .addr(addr_trimmed),
        .write_data(reg_data2),
        .read_data(data_mem_out)
    );

    // Data Out Mux
    mux2x1 #(DATA_WIDTH) data_mux (
        .select(MemtoReg),
        .S0(Result), // ALU result
        .S1(data_mem_out), // Data memory output
        .mux_out(write_data)
    );
endmodule
