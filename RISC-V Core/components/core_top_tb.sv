`timescale 1ns / 1ns

module core_top_tb;
    logic clk = 0;
    logic reset = 1;

    core_top uut (
        .clk_i(clk),
        .reset_i(reset)
    );

    always #5 clk = ~clk; // 100 MHz clock

    initial begin
        reset = 0;
        #10 reset = 1;
        #50 reset = 0;
        #1000;
        $display("Simulation finished.");
        $finish;
    end
endmodule
