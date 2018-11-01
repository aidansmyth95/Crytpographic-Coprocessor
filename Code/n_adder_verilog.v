module n_adder_verilog(A_BUS,B_BUS,CIN,SUM);

   parameter N=16;
   input [N-1:0] A_BUS,B_BUS;
   input CIN;
   output [N-1:0] SUM;
   wire  cout;
   wire [N-1:0] c_internal;
   genvar i;
   generate 
   for(i=0;i<N;i=i+1)
     begin: generate_N_adder
   if(i==0) 
  full_adder_verilog f0 (A_BUS[0],B_BUS[0],CIN,SUM[0],c_internal[0]);
   else
  full_adder_verilog fi (A_BUS[i],B_BUS[i],c_internal[i-1],SUM[i],c_internal[i]);
     end
  assign cout = c_internal[N-1];
   endgenerate
   
   
endmodule 
