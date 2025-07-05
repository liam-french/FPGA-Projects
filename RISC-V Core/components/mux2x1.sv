module mux2x1 #(parameter int Width) (
    input logic [Width-1:0] S0, S1,
    input logic select,
    output logic [Width-1:0] mux_out
    );
    always_comb begin
        mux_out = (select) ? S1 : S0;
    end
endmodule
