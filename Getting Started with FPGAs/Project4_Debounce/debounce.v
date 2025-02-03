module Debounce_Filter #(parameter DEBOUNCE_LIMIT = 20) (
    input i_Clk,
    input i_Bouncy,
    output o_Debounced);

    // 1 Ceiling Log base 2 Function to determine counter reg size dynamically
    // VHDL implements this easily using integers and range keyword
    reg [$clog2(DEBOUNCE_LIMIT)-1:0] r_Count = 0;
    reg r_State =1'b0;
    always @(posedge i_Clk)
    begin
        // 2
        if (i_Bouncy !== r_State && r_Count < DEBOUNCE_LIMIT-1)
        begin
            r_Count <= r_Count + 1;
        end
        // 3
        else if (r_Count == DEBOUNCE_LIMIT-1)
        begin
            r_State <= i_Bouncy;
            r_Count <= 0;
        end
        else
        begin
        // 4 Set count to 0 if state == input as we only want to debounce a new state
            r_Count <= 0;
        end
    end
    // 5
    assign o_Debounced = r_State;
endmodule