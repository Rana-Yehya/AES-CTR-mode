module Coloumn_Wise (input [127:0] inp_row , output reg [127:0] out_col );

always @(*) begin 
     out_col [127:120] = inp_row [127:120] ;
     out_col [119:112] = inp_row [95 : 88] ;
     out_col [111:104] = inp_row [63 : 56] ;
     out_col [103:96 ] = inp_row [31 : 24] ;
     out_col [95 : 88] = inp_row [119:112] ;
     out_col [87 :80 ] = inp_row [87 :80 ] ;
     out_col [79 :72 ] = inp_row [55 :48 ] ;
     out_col [71 :64 ] = inp_row [23 : 16] ;
     out_col [63 :56 ] = inp_row [111:104] ;
     out_col [55 :48 ] = inp_row [79 :72 ] ;
     out_col [47 :40 ] = inp_row [47 :40 ] ;
     out_col [39 : 32] = inp_row [15 :8  ] ;
     out_col [31 : 24] = inp_row [103: 96] ;
     out_col [23 :16 ] = inp_row [71 :64 ] ;
     out_col [15 :8  ] = inp_row [39 :32 ] ;
     out_col [7  :0  ] = inp_row [7  :0  ] ;
end
endmodule


 
