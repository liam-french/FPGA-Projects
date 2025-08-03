
// Clocks per bit = F/BR
// 25 MHz / 115200 = 217 CC
// Based on https://nandland.com/uart-serial-port-module/
module uart_tx #(
    parameter int CCS_PER_BIT = 217
)(
    input logic       clk_i,
    input logic [7:0] tx_byte_i,
    input logic       tx_valid_i,

    output logic tx_data_o,
    output logic tx_done_o
);

    // LOCAL PARAMETERS
    localparam int CC_COUNT_WIDTH = $clog2(CCS_PER_BIT);

    // TYPES
    typedef enum logic [2:0] { 
        IDLE, START, DATA, STOP, DONE
    } tx_state_t;

    // SIGNALS
    logic [CC_COUNT_WIDTH-1:0] cc_count;
    logic [2:0]                tx_data_index;
    logic [7:0]                tx_byte;
    logic                      tx_done;

    tx_state_t state = IDLE;

    always_ff @(posedge clk_i) begin
        case (state)
            IDLE: begin
                cc_count      <= 0;
                tx_data_index <= 0;
                tx_done     <= 1'b0;
                tx_data_o     <= 1'b1; // Line is high on idle

                // Check if the input data is valid
                if (tx_valid_i == 1'b1) begin
                    tx_byte <= tx_byte_i; // latch/register incoming data
                    state <= START;
                end
                else begin
                    state <= IDLE;
                end
            end

            START: begin
                tx_data_o <= 1'b0; // Pull line low to indicate start

                if (cc_count < CCS_PER_BIT - 1) begin
                    cc_count  <= cc_count + 1;
                    state <= START;
                end
                else begin
                    cc_count <= 0;
                    state    <= DATA;
                end
            end

            DATA: begin
                tx_data_o <= tx_byte[tx_data_index];

                if (cc_count < CCS_PER_BIT - 1) begin
                    cc_count <= cc_count + 1;
                    state <= DATA;
                end
                else begin
                    cc_count               <= 0;

                    if (tx_data_index < 7) begin
                        tx_data_index <= tx_data_index + 1;
                        state         <= DATA;
                    end
                    else begin
                        tx_data_index <= 0;
                        state         <= STOP;
                    end
                end
            end

            STOP: begin
                tx_data_o <= 1'b1;

                if (cc_count < CCS_PER_BIT - 1) begin
                    cc_count  <= cc_count + 1;
                    state <= STOP;
                end
                else begin
                    tx_done <= 1'b1;
                    state     <= DONE;
                end
            end

            DONE: begin
                tx_done <= 1'b1;
                state     <= IDLE;
            end

            default: begin
                state <= IDLE;
            end
        endcase
    end

    assign tx_done_o = tx_done;

endmodule

module uart_rx #(
    parameter int CCS_PER_BIT = 217
)(
    input logic clk_i,
    input logic rx_data_i,

    output logic [7:0] rx_byte_o,
    output logic       rx_valid_o
);
    // LOCAL PARAMETERS
    localparam int CC_COUNT_WIDTH = $clog2(CCS_PER_BIT);

    // TYPES
    typedef enum logic [2:0] { 
        IDLE, START, DATA, STOP, DONE
    } rx_state_t;

    // SIGNALS
    logic [CC_COUNT_WIDTH-1:0] cc_count;
    logic [2:0]                rx_data_index;
    logic [7:0]                rx_byte;
    logic                      rx_valid;
    logic                      rx_data [2];

    rx_state_t state = IDLE;

    // RX Buffer (metastability)
    always_ff @(posedge clk_i) begin
        rx_data[0] <= rx_data_i;
        rx_data[1] <= rx_data[0];
    end

    // RX State Machine
    always_ff @(posedge clk_i) begin
        case (state)
            IDLE: begin
                rx_valid      <= 1'b0;
                cc_count      <= 0;
                rx_data_index <= 0;

                // Check if line has been pulled low
                if (rx_data[1] == 1'b0) begin
                    state <= START;
                end
            end

            START: begin
                // Wait until the middle of the signal to check (best integrity?)
                if (cc_count < CCS_PER_BIT / 2) begin
                    cc_count <= cc_count + 1;
                    state <= START;
                end
                else begin
                    if (rx_data[1] == 1'b0) begin
                        cc_count <= 0;
                        state    <= DATA;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
            end

            DATA: begin
                if (cc_count < CCS_PER_BIT - 1) begin
                    cc_count <= cc_count + 1;
                    state <= DATA;
                end
                else begin
                    cc_count               <= 0;
                    rx_byte[rx_data_index] <= rx_data[1];

                    if (rx_data_index < 7) begin
                        rx_data_index <= rx_data_index + 1;
                        state         <= DATA;
                    end
                    else begin
                        rx_data_index <= 0;
                        state         <= STOP;
                    end
                end
            end

            STOP: begin // Receive the stop bit
                if (cc_count < CCS_PER_BIT - 1) begin
                    cc_count <= cc_count + 1;
                    state    <= STOP;
                end
                else begin
                    rx_valid <= 1'b1;
                    state <= DONE;
                end
            end

            DONE: begin // Extra state to ensure rx_valid_o is high for exactly 1 cc
                        // unsure if this is 100% necessary, will test
                rx_valid <= 1'b0;
                state <= IDLE;
            end

            default: begin
                state <= IDLE;
            end
        endcase
    end

    assign rx_byte_o  = rx_byte;
    assign rx_valid_o = rx_valid;
endmodule

