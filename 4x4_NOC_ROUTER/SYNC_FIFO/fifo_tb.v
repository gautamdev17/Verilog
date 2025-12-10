// TESTBENCH
`timescale 1ns/1ps
module fifo_tb();
  parameter DATA_WIDTH = 32;
  parameter DEPTH      = 8;

  reg clk,rst,rd_en,wr_en;
  reg  [DATA_WIDTH-1:0] data_in;
  wire full,empty,data_valid;
  wire [DATA_WIDTH-1:0] data_out;
  
  fifo #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) inst1 (
    clk,rst,rd_en,wr_en,data_in,
    full,empty,data_valid,data_out
  );
  
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $monitor("t=%0t clk=%0b rst=%0b wr=%0b rd=%0b full=%0b empty=%0b valid=%0b data_in=%h data_out=%h",
             $time, clk, rst, wr_en, rd_en, full, empty, data_valid, data_in, data_out);
  end

  initial begin
    rst    = 1;
    rd_en  = 0;
    wr_en  = 0;
    data_in = '0;
    #20;
    rst = 0;

    #10;
    wr_en   = 1;
    rd_en   = 0;
    data_in = {8{4'b0001}};
    #10; 
    wr_en   = 0;
    data_in = '0;

    #20;
    rd_en = 1;
    #10;
    rd_en = 0;

    for (int i = 0; i < DEPTH; i = i+1) begin
      wr_en   = 1;
      rd_en   = 0;
      data_in = {i[3:0], i[3:0], i[3:0], i[3:0],
                 i[3:0], i[3:0], i[3:0], i[3:0]};
      #10;
    end
    wr_en   = 0;
    data_in = '0;

    #20;
    wr_en   = 1;
    rd_en   = 0;
    data_in = {8{4'b1111}};
    #10;
    wr_en   = 0;
    data_in = '0;

    #20;
    for (int i = 0; i < DEPTH; i = i+1) begin
      rd_en = 1;
      wr_en = 0;
      #10;
    end
    rd_en = 0;

    #20;
    rd_en = 1;
    #20;
    rd_en = 0;


    #20;
    wr_en   = 1;
    rd_en   = 0;
    data_in = 32'hAAAA_AAAA;
    #10;

    wr_en   = 1;
    rd_en   = 1;
    data_in = 32'hBBBB_BBBB;
    #10;

    wr_en   = 0;
    rd_en   = 1;
    data_in = '0;
    #20;

    rd_en = 0;
    #50;
    $finish;
  end
endmodule
