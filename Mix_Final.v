module final_mix (input [31:0] row , input [127:0] coloumns , output [31:0] row_out ) ;
	
	wire [31:0] container     ;
	wire [31:0] container1    ;
	wire [31:0] container2    ;
	wire [31:0] container3    ;

// First element 

	Mix_Coulmn55 mix1 (.inp1(row[31:24]),.inp2(coloumns[127:120]) , .out(container [31:24]) ) ;
	Mix_Coulmn55 mix2 (.inp1(row[23:16]),.inp2(coloumns[95 :88 ]) , .out(container [23:16]) ) ;
	Mix_Coulmn55 mix3 (.inp1(row[15:8 ]),.inp2(coloumns[63 :56 ]) , .out(container [15:8 ]) ) ;
	Mix_Coulmn55 mix4 (.inp1(row[7 :0 ]),.inp2(coloumns[31 :24 ]) , .out(container [7 :0 ]) ) ;
	
	assign row_out [31:24] = container [31:24] ^ container [23:16] ^ container [15:8] ^ container [7:0];
//________________________________________________________________________________________________________________
// Second element 
	Mix_Coulmn55 mix5 (.inp1(row[31:24]),.inp2(coloumns[119:112]) , .out(container1[31:24]) ) ;
	Mix_Coulmn55 mix6 (.inp1(row[23:16]),.inp2(coloumns[87 :80 ]) , .out(container1[23:16]) ) ;
	Mix_Coulmn55 mix7 (.inp1(row[15:8 ]),.inp2(coloumns[55 :48 ]) , .out(container1[15:8 ]) ) ;
	Mix_Coulmn55 mix8 (.inp1(row[7 :0 ]),.inp2(coloumns[23 :16 ]) , .out(container1[7 :0 ]) ) ;
	
	assign row_out [23:16] = container1[31:24] ^ container1[23:16] ^ container1[15:8] ^ container1[7:0];
//________________________________________________________________________________________________________________
// Third element 
	Mix_Coulmn55 mix9 (.inp1(row[31:24]),.inp2(coloumns[111:104]) , .out(container2[31:24]) ) ;
	Mix_Coulmn55 mix10(.inp1(row[23:16]),.inp2(coloumns[79 :72 ]) , .out(container2[23:16]) ) ;
	Mix_Coulmn55 mix11(.inp1(row[15:8 ]),.inp2(coloumns[47 :40 ]) , .out(container2[15:8 ]) ) ;
	Mix_Coulmn55 mix12(.inp1(row[7 :0 ]),.inp2(coloumns[15 :8  ]) , .out(container2[7 :0 ]) ) ;
	
	assign row_out [15:8] = container2[31:24] ^ container2[23:16] ^ container2[15:8] ^ container2[7:0];

//________________________________________________________________________________________________________________
// Fourth element 

	Mix_Coulmn55 mix13(.inp1(row[31:24]),.inp2(coloumns[103:96 ]) , .out(container3[31:24]) ) ;
	Mix_Coulmn55 mix14(.inp1(row[23:16]),.inp2(coloumns[71 :64 ]) , .out(container3[23:16]) ) ;
	Mix_Coulmn55 mix15(.inp1(row[15:8 ]),.inp2(coloumns[39 :32 ]) , .out(container3[15:8 ]) ) ;
	Mix_Coulmn55 mix16(.inp1(row[7 :0 ]),.inp2(coloumns[7  :0  ]) , .out(container3[7 :0 ]) ) ;
	
	assign row_out [7 :0 ] = container3[31:24] ^ container3[23:16] ^ container3[15:8] ^ container3[7:0];

endmodule
