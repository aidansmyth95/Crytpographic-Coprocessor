module full_adder_verilog(A,B,CIN,SUM,COUT);
   
   input A,B,CIN;
   output SUM,COUT;
 
   assign SUM = (A ^ B) ^ CIN;
   assign COUT = (A & B)| (A & CIN) | (CIN & B);

endmodule