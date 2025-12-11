`timescale 1ns/1ps
module tb();
  reg [14:0]selsignal;
  reg [4:0] input_data[4:0];
  wire [24:0] final_out;
  
  crossbar inst1(selsignal,input_data,final_out);
  
  initial begin
    $monitor("%4t sels=%05o out={%05b,%05b,%05b,%05b,%05b}",
         $time, selsignal,
         final_out[24:20], final_out[19:15],
         final_out[14:10], final_out[9:5], final_out[4:0]);
  end
  initial begin
 #0;input_data[0] = 5'b01101;
    input_data[1] = 5'b10001;
    input_data[2] = 5'b11111;
    input_data[3] = 5'b00000;
    input_data[4] = 5'b10100;
    selsignal = 0;
    #5;selsignal = 15'o12340;
    #10;selsignal = 15'o43021;
    #15;selsignal = 15'o02143;
    #10;$finish;
  end
endmodule
