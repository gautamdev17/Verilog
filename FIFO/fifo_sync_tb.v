`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 11:22:35
// Design Name: 
// Module Name: fifo_synctb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module fifo_synctb();
    parameter FIFO_DEPTH = 8, DATA_WIDTH = 8;

    // Signals
    reg clk = 0;
    reg rstb;
    reg cs;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire full, empty;

    integer i;

    // FIFO instantiation
    fifo_sync #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rstb(rstb),
        .cs(cs),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // 1️⃣ Reset sequence
        rstb = 0; cs = 0; wr_en = 0; rd_en = 0; data_in = 0;
        #20;  // hold reset for 2 cycles
        rstb = 1; cs = 1;
        $display("=== Reset released ===");

        // 2️⃣ Fill FIFO
        $display("=== Writing to FIFO ===");
        for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
            @(posedge clk);
            wr_en = 1;
            rd_en = 0;
            data_in = $random % 256;  // random 8-bit data
            $display("Writing: %h, full=%b, empty=%b", data_in, full, empty);
        end
        wr_en = 0;

        // 3️⃣ Read FIFO completely
        $display("=== Reading from FIFO ===");
        for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
            @(posedge clk);
            wr_en = 0;
            rd_en = 1;
            $display("Reading: %h, full=%b, empty=%b", data_out, full, empty);
        end
        rd_en = 0;

        // 4️⃣ Random write/read test
        $display("=== Random Read/Write Test ===");
        for (i = 0; i < 20; i = i + 1) begin
            @(posedge clk);
            wr_en = $random % 2;
            rd_en = $random % 2;

            // If write enabled and FIFO not full
            if (wr_en && !full) begin
                data_in = $random % 256;
                $display("Random Write: %h", data_in);
            end else wr_en = 0;

            // If read enabled and FIFO not empty
            if (rd_en && !empty) begin
                $display("Random Read: %h", data_out);
            end else rd_en = 0;

            $display("Status: full=%b, empty=%b, wr=%b, rd=%b", full, empty, wr_en, rd_en);
        end

        $display("=== Test Finished ===");
        $finish;
    end
endmodule
