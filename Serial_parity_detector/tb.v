`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2025 21:02:28
// Design Name: 
// Module Name: paritytb
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


module paritytb();
    reg x,clk;
    wire y;
    parity inst1(x,clk,y);
    initial clk=0;
    always #5 clk=~clk;
    initial begin
        #0;x=0;
        #11;x=1;
        #11;x=1;
        #11;x=0;
        #11;x=1;
        #11;
        $finish;
    end
endmodule
