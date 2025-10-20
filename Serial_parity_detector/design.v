`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2025 18:01:06
// Design Name: 
// Module Name: parity
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


module parity(input x,clk,output y);
    parameter S0 = 1'b0,S1=1'b1;
    reg state;
    wire y;
    initial state = 1'b0;
    always @(posedge clk) begin
        case(state)
            S0: state<=x?S1:S0;
            S1: state<=x?S0:S1;
            default: state<=S0;
        endcase
    end
    assign y = state;
endmodule
