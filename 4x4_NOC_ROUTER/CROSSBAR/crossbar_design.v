module crossbar(input [14:0]selsignal,input [4:0]input_data[4:0],output [24:0] final_out);
  assign final_out[24:20] = input_data[selsignal[14:12]];
  assign final_out[19:15] = input_data[selsignal[11:9]];
  assign final_out[14:10] = input_data[selsignal[8:6]];
  assign final_out[9:5] = input_data[selsignal[5:3]];
  assign final_out[4:0] = input_data[selsignal[2:0]];
  integer i;
  /*for(i=0;i<5;i=i+1) begin
    assign final_out[(i+1)*5-1:i*5] = input_data[sel_signal[(i+1)*3:i*3]]; 
  end*/
  // check how to implement in for loop bro!!! plz don't forget
endmodule
