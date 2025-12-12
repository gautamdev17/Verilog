/*first define inputs outputs
input is the reqmat
output is the sel signal
set all ptrs to i0
req mat is unrolled per column, but in my code i have already rolled out the columns
start from ptr per column and if 1 detected give that the grant and set ptr = granted input + 1
send grants as 3bit binary encoded values since it saves up space and send as sel signal*/


// switched to system verilog since verilog didnt allow dynamic slicing
// use dynamic part-select base +: width
`timescale 1ns/1ps

module switch_allocator(
  input  logic [24:0] reqMat,
  input  logic clk,
  input  logic rst,
  output logic [2:0] selsignal [4:0], //select winners for each direction
  output logic [4:0] fifo_pop //winnner inputs are popped and next header flit is read for the nxt cycle
// losers arent popped and have to wait the next clock efge
);
  //use 15 bit for SEL SIGNAL represent each winner of an output port in 3 bits
  reg [2:0]rrbptr [4:0];
  integer i,j,k;
  logic f; // f is flag
  
  always_ff @(posedge clk) begin
    if (rst) begin
      for(i=0;i<5;i=i+1) begin
        rrbptr[i]<=3'b0;
        selsignal[i]<=3'b0;
      end
    	  fifo_pop<=5'b0;
    end else begin
      for(i=0;i<5;i=i+1) begin
        selsignal[i]<=3'b0;
      end
      fifo_pop <= 0;
      for (i=0;i<5;i=i+1) begin //go to each direction
        f=0;k=0;
        // run from rrb to a full circle
        for (j=rrbptr[i];k!= 5;j=(j==4)?0:j+1) begin
          k=k+1;
          if (reqMat[i*5+j]==1'b1 && !f) begin
            //bro so im doing dynamic slicing here and this is the format in sv
            selsignal[i]<=j[2:0];//assign winner to respective direction
            rrbptr[i]<=(j==4)?3'b0:j+1;//rrb ptr will change for nxt cucle
            fifo_pop[j]<=1'b1;//pop the fifo for winner inputs
            f=1; //stop here running the inner loop, winner found
          end
        end
      end
    end
  end
endmodule
