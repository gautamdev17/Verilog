`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2025 12:35:30
// Design Name: 
// Module Name: fsmtb
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


module fsmtb();
    reg x,clk;
    wire qa,qb,y;
    fsmdesign inst1(x,clk,qa,qb,y);
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    initial begin
        #0;x=0;
        #10;x=1;
        #10;x=1;
        #10;x=1;
        #10;x=1;
        #10;x=0;
        #10;x=1;
        #10;x=0;
        $finish;
    end
endmodule
