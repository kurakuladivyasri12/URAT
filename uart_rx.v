module uart_rx #(
    parameter CLK_FREQ  = 10_000_000,
    parameter BAUD_RATE = 1_000_000
)(
    input  wire       clk,
    input  wire       reset,
    input  wire       rx,

    output reg [7:0]  data_out,
    output reg        data_valid
);

    localparam integer CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    reg [7:0] data_reg;
    reg [3:0] bit_count;

    integer clk_count;

    reg receiving;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            data_out   <= 8'b0;
            data_valid <= 1'b0;
            data_reg   <= 8'b0;
            bit_count  <= 4'd0;
            clk_count  <= 0;
            receiving  <= 1'b0;
        end

        else begin

            data_valid <= 1'b0;

            if (!receiving) begin

                // Detect start bit
                if (rx == 1'b0) begin
                    receiving <= 1'b1;
                    clk_count <= CLKS_PER_BIT / 2;
                    bit_count <= 0;
                end

            end

            else begin

                if (clk_count < CLKS_PER_BIT - 1) begin
                    clk_count <= clk_count + 1;
                end

                else begin
                    clk_count <= 0;

                    if (bit_count < 8) begin
                        data_reg[bit_count] <= rx;
                        bit_count <= bit_count + 1;
                    end

                    else begin
                        // Stop bit
                        data_out   <= data_reg;
                        data_valid <= 1'b1;

                        receiving <= 1'b0;
                        bit_count <= 0;
                    end
                end
            end
        end
    end

endmodule