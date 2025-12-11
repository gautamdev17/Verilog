`timescale 1ns/1ps

module SA_tb();

  reg  [24:0] reqMat;
  reg  clk, rst;
  wire [14:0] selsignal;
  wire [4:0]  fifo_pop;

  switch_allocator inst1 (
    .reqMat(reqMat),
    .clk(clk),
    .rst(rst),
    .selsignal(selsignal),
    .fifo_pop(fifo_pop)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $monitor("t=%0t reqMat=%h sel=%o pop=%b",
             $time, reqMat, selsignal, fifo_pop);
  end

  initial begin
    rst = 1;
    reqMat = 0;
    @(posedge clk); @(posedge clk);
    rst = 0;

    @(posedge clk); reqMat = 25'h24802;
    @(posedge clk); reqMat = 25'h11111;
    @(posedge clk); reqMat = 25'h08241;
    @(posedge clk); reqMat = 25'h00001;
    @(posedge clk); reqMat = 25'h10000;

    @(posedge clk);
    $finish;
  end

endmodule
