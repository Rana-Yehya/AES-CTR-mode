module finalfinal_mix (input [127:0] message ,output [127:0] inv_mixout);
  reg [127:0] const_inverse    ;    
  wire[127:0] const_inverse_w  ;

  assign const_inverse_w = const_inverse ;

  final_mix one   (.row(const_inverse_w[127:96]) , .coloumns(message) , .row_out(inv_mixout[127:96] )) ;
  final_mix two   (.row(const_inverse_w[95 :64]) , .coloumns(message) , .row_out(inv_mixout[95 :64] )) ;
  final_mix three (.row(const_inverse_w[63 :32]) , .coloumns(message) , .row_out(inv_mixout[63 :32] )) ;
  final_mix four  (.row(const_inverse_w[31 :0 ]) , .coloumns(message) , .row_out(inv_mixout[31 :0 ] )) ;	
endmodule
