`timescale 1ns/1ps
`include "../alu.vh"

module alu_tb;

    localparam int DATA_WIDTH = 32;

    logic [DATA_WIDTH-1:0] A, B;
    logic [3:0] ALUCtl;
    logic [DATA_WIDTH-1:0] Result;
    logic Zero;

    alu #(.DATA_WIDTH(DATA_WIDTH)) dut (
        .A(A),
        .B(B),
        .ALUCtl(ALUCtl),
        .Result(Result),
        .Zero(Zero)
    );

    task automatic check(
            input logic [DATA_WIDTH-1:0] a,
            input logic [DATA_WIDTH-1:0] b,
            input logic [3:0] ctl,
            input logic [DATA_WIDTH-1:0] exp_result,
            input logic exp_zero
        );
        begin
            A = a;
            B = b;
            ALUCtl = ctl;
            #1;
            if (Result !== exp_result || Zero !== exp_zero) begin
                $display("FAIL: A=%h B=%h ALUCtl=%h | Result=%h (exp %h) Zero=%b (exp %b)", a, b, ctl, Result, exp_result, Zero, exp_zero);
            end else begin
                $display("PASS: A=%h B=%h ALUCtl=%h | Result=%h Zero=%b", a, b, ctl, Result, Zero);
            end
        end
    endtask

    initial begin
        $display("Starting ALU testbench...");

        check(32'd01, 32'd02, ALU_ADD, 32'd03, 0);
        check(32'd20, 32'd00, ALU_ADD, 32'd20, 0);
        check(32'hFFFF_FFFF, 32'd1, ALU_ADD, 32'd0, 1);

        check(32'h1234_5678, 32'h8765_4321, 4'hF, 32'h0000_0000, 1);

        $display("ALU testbench completed.");
        $finish;
    end

endmodule
