`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 10:17:08
// Design Name: 
// Module Name: fifo_sync
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


module fifo_sync #(parameter FIFO_DEPTH = 8,parameter DATA_WIDTH = 32) (input clk,input rstb,input cs//chip select
,input wr_en,input rd_en,input [DATA_WIDTH-1:0]data_in,output reg [DATA_WIDTH-1:0]data_out,
output full,empty);
    localparam FIFO_DEPTH_LOG = $clog2(FIFO_DEPTH);//$clog2(8) = 3--->3bits, 000 to 111
    reg [DATA_WIDTH-1:0] mem [0:FIFO_DEPTH-1];// depth = 8---> [0:7] 32 bit elements
    reg [FIFO_DEPTH_LOG:0] wr_ptr;//wr/rd pointers have one extra bit [3:0]
    reg [FIFO_DEPTH_LOG:0] rd_ptr;
    
    //write
    always @(posedge clk or negedge rstb) begin
        if(!rstb)
            wr_ptr<=0;
        else if (cs && wr_en && !full) begin
            mem[wr_ptr[FIFO_DEPTH_LOG-1:0]] <= data_in;
            wr_ptr<=wr_ptr+1'b1;
        end
    end
    
    //read
    always @(posedge clk or negedge rstb) begin
        if(!rstb)
            rd_ptr<=0;
        else if (cs && rd_en && !empty) begin
            data_out<=mem[rd_ptr[FIFO_DEPTH_LOG-1:0]];
            rd_ptr<=rd_ptr+1'b1;
        end
    end
    
    //empty/full
    assign empty = (wr_ptr == rd_ptr);
    assign full = ({~wr_ptr[FIFO_DEPTH_LOG],wr_ptr[FIFO_DEPTH_LOG-1:0]} == rd_ptr);
endmodule
