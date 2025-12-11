module crossbar(input [14:0]selsignal,input [4:0]input_data[4:0],input [4:0]fifo_pop,output [24:0] final_out);
  //write to output only if an input was granted to that direction
  assign final_out[24:20] = fifo_pop[4]?input_data[selsignal[14:12]]:0; //north
  assign final_out[19:15] = fifo_pop[3]?input_data[selsignal[11:9]]:0; //south
  assign final_out[14:10] = fifo_pop[2]?input_data[selsignal[8:6]]:0; //east
  assign final_out[9:5] = fifo_pop[1]?input_data[selsignal[5:3]]:0; //west
  assign final_out[4:0] = fifo_pop[0]?input_data[selsignal[2:0]]:0; //local
  /*integer i;
  for(i=0;i<5;i=i+1) begin
    assign final_out[(i+1)*5-1:i*5] = input_data[sel_signal[(i+1)*3:i*3]]; 
  end*/
  // check how to implement in for loop bro!!! plz don't forget
endmodule
