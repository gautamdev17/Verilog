`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2025 12:31:02
// Design Name: 
// Module Name: fsmdesign
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


module fsmdesign(input x,clk,output reg qa,qb,y);
    initial begin
        qa = 0;
        qb = 0;
        y  = 0;
    end
    always @(posedge clk) begin
        qa<=(~qa)&qb&x | qa&(~qb)&x;
        qb<=(~qa)&(~qb)&(~x) | qa&(~qb)&x;
        y<=qa&qb;
    end
endmodule
