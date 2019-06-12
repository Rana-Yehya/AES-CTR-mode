
module Sub_byte128 (input wire [127:0] W,output reg [127:0] bytes_out);

reg [7:0] s_box [15:0][15:0];
//reg [127:0] bytes_next;


initial
begin
 	// first row 
	s_box[0][0] = 8'h63;
	s_box[0][1] = 8'h7C;
	s_box[0][2] = 8'h77;
	s_box[0][3] = 8'h7B;
	s_box[0][4] = 8'hF2;
	s_box[0][5] = 8'h6B;
	s_box[0][6] = 8'h6F;
	s_box[0][7] = 8'hC5;
	s_box[0][8] = 8'h30;
	s_box[0][9] = 8'h01;
	s_box[0][10] = 8'h67;
	s_box[0][11] = 8'h2B;
	s_box[0][12] = 8'hFE;
	s_box[0][13] = 8'hD7;
	s_box[0][14] = 8'hAB;
	s_box[0][15] = 8'h76;


 	// second row 
	s_box[1][0] = 8'hCA;
	s_box[1][1] = 8'h82;
	s_box[1][2] = 8'hC9;
	s_box[1][3] = 8'h7D;
	s_box[1][4] = 8'hFA;
	s_box[1][5] = 8'h59;
	s_box[1][6] = 8'h47;
	s_box[1][7] = 8'hF0;
	s_box[1][8] = 8'hAD;
	s_box[1][9] = 8'hD4;
	s_box[1][10] = 8'hA2;
	s_box[1][11] = 8'hAF;
	s_box[1][12] = 8'h9C;
	s_box[1][13] = 8'hA4;
	s_box[1][14] = 8'h72;
	s_box[1][15] = 8'hC0;

 	// third row 
	s_box[2][0] = 8'hB7;
	s_box[2][1] = 8'hFD;
	s_box[2][2] = 8'h93;
	s_box[2][3] = 8'h26;
	s_box[2][4] = 8'h36;
	s_box[2][5] = 8'h3F;
	s_box[2][6] = 8'hF7;
	s_box[2][7] = 8'hCC;
	s_box[2][8] = 8'h34;
	s_box[2][9] = 8'hA5;
	s_box[2][10] = 8'hE5;
	s_box[2][11] = 8'hF1;
	s_box[2][12] = 8'h71;
	s_box[2][13] = 8'hD8;
	s_box[2][14] = 8'h31;
	s_box[2][15] = 8'h15;


 	// fourth row 
	s_box[3][0] = 8'h04;
	s_box[3][1] = 8'hC7;
	s_box[3][2] = 8'h23;
	s_box[3][3] = 8'hC3;
	s_box[3][4] = 8'h18;
	s_box[3][5] = 8'h96;
	s_box[3][6] = 8'h05;
	s_box[3][7] = 8'h9A;
	s_box[3][8] = 8'h07;
	s_box[3][9] = 8'h12;
	s_box[3][10] = 8'h80;
	s_box[3][11] = 8'hE2;
	s_box[3][12] = 8'hEB;
	s_box[3][13] = 8'h27;
	s_box[3][14] = 8'hB2;
	s_box[3][15] = 8'h75;



 	// fifth row 
	s_box[4][0] = 8'h09;
	s_box[4][1] = 8'h83;
	s_box[4][2] = 8'h2C;
	s_box[4][3] = 8'h1A;
	s_box[4][4] = 8'h1B;
	s_box[4][5] = 8'h6E;
	s_box[4][6] = 8'h5A;
	s_box[4][7] = 8'hA0;
	s_box[4][8] = 8'h52;
	s_box[4][9] = 8'h3B;
	s_box[4][10] = 8'hD6;
	s_box[4][11] = 8'hB3;
	s_box[4][12] = 8'h29;
	s_box[4][13] = 8'hE3;
	s_box[4][14] = 8'h2F;
	s_box[4][15] = 8'h84;



 	// sixth row 
	s_box[5][0]  = 8'h53;
	s_box[5][1]  = 8'hD1;
	s_box[5][2]  = 8'h00;
	s_box[5][3]  = 8'hED;
	s_box[5][4]  = 8'h20;
	s_box[5][5]  = 8'hFC;
	s_box[5][6]  = 8'hB1;
	s_box[5][7]  = 8'h5B;
	s_box[5][8]  = 8'h6A;
	s_box[5][9]  = 8'hCB;
	s_box[5][10] = 8'hBE;
	s_box[5][11] = 8'h39;
	s_box[5][12] = 8'h4A;
	s_box[5][13] = 8'h4C;
	s_box[5][14] = 8'h58;
	s_box[5][15] = 8'hCF;


 	// seventh row 
	s_box[6][0] = 8'hD0;
	s_box[6][1] = 8'hEF;
	s_box[6][2] = 8'hAA;
	s_box[6][3] = 8'hFB;
	s_box[6][4] = 8'h43;
	s_box[6][5] = 8'h4D;
	s_box[6][6] = 8'h33;
	s_box[6][7] = 8'h85;
	s_box[6][8] = 8'h45;
	s_box[6][9] = 8'hF9;
	s_box[6][10] = 8'h02;
	s_box[6][11] = 8'h7F;
	s_box[6][12] = 8'h50;
	s_box[6][13] = 8'h3C;
	s_box[6][14] = 8'h9F;
	s_box[6][15] = 8'hA8;

 	// eighth row 
	s_box[7][0] = 8'h51;
	s_box[7][1] = 8'hA3;
	s_box[7][2] = 8'h40;
	s_box[7][3] = 8'h8F;
	s_box[7][4] = 8'h92;
	s_box[7][5] = 8'h9D;
	s_box[7][6] = 8'h38;
	s_box[7][7] = 8'hF5;
	s_box[7][8] = 8'hBC;
	s_box[7][9] = 8'hB6;
	s_box[7][10] = 8'hDA;
	s_box[7][11] = 8'h21;
	s_box[7][12] = 8'h10;
	s_box[7][13] = 8'hFF;
	s_box[7][14] = 8'hF3;
	s_box[7][15] = 8'hD2;

 	// ninth row 
	s_box[8][0] = 8'hCD;
	s_box[8][1] = 8'h0C;
	s_box[8][2] = 8'h13;
	s_box[8][3] = 8'hEC;
	s_box[8][4] = 8'h5F;
	s_box[8][5] = 8'h97;
	s_box[8][6] = 8'h44;
	s_box[8][7] = 8'h17;
	s_box[8][8] = 8'hC4;
	s_box[8][9] = 8'hA7;
	s_box[8][10] = 8'h7E;
	s_box[8][11] = 8'h3D;
	s_box[8][12] = 8'h64;
	s_box[8][13] = 8'h5D;
	s_box[8][14] = 8'h19;
	s_box[8][15] = 8'h73;


 	// tenth row 
	s_box[9][0] = 8'h60;
	s_box[9][1] = 8'h81;
	s_box[9][2] = 8'h4F;
	s_box[9][3] = 8'hDC;
	s_box[9][4] = 8'h22;
	s_box[9][5] = 8'h2A;
	s_box[9][6] = 8'h90;
	s_box[9][7] = 8'h88;
	s_box[9][8] = 8'h46;
	s_box[9][9] = 8'hEE;
	s_box[9][10] = 8'hB8;
	s_box[9][11] = 8'h14;
	s_box[9][12] = 8'hDE;
	s_box[9][13] = 8'h5E;
	s_box[9][14] = 8'h0B;
	s_box[9][15] = 8'hDB;



	// eleventh row 
	s_box[10][0] = 8'hE0;
	s_box[10][1] = 8'h32;
	s_box[10][2] = 8'h3A;
	s_box[10][3] = 8'h0A;
	s_box[10][4] = 8'h49;
	s_box[10][5] = 8'h06;
	s_box[10][6] = 8'h24;
	s_box[10][7] = 8'h5C;
	s_box[10][8] = 8'hC2;
	s_box[10][9] = 8'hD3;
	s_box[10][10] = 8'hAC;
	s_box[10][11] = 8'h62;
	s_box[10][12] = 8'h91;
	s_box[10][13] = 8'h95;
	s_box[10][14] = 8'hE4;
	s_box[10][15] = 8'h79;

	// twelveth row 
	s_box[11][0] = 8'hE7;
	s_box[11][1] = 8'hC8;
	s_box[11][2] = 8'h37;
	s_box[11][3] = 8'h6D;
	s_box[11][4] = 8'h8D;
	s_box[11][5] = 8'hD5;
	s_box[11][6] = 8'h4E;
	s_box[11][7] = 8'hA9;
	s_box[11][8] = 8'h6C;
	s_box[11][9] = 8'h56;
	s_box[11][10] = 8'hF4;
	s_box[11][11] = 8'hEA;
	s_box[11][12] = 8'h65;
	s_box[11][13] = 8'h7A;
	s_box[11][14] = 8'hAE;
	s_box[11][15] = 8'h08;


	// thirteenth row 
	s_box[12][0] = 8'hBA;
	s_box[12][1] = 8'h78;
	s_box[12][2] = 8'h25;
	s_box[12][3] = 8'h2E;
	s_box[12][4] = 8'h1C;
	s_box[12][5] = 8'hA6;
	s_box[12][6] = 8'hB4;
	s_box[12][7] = 8'hC6;
	s_box[12][8] = 8'hE8;
	s_box[12][9] = 8'hDD;
	s_box[12][10] = 8'h74;
	s_box[12][11] = 8'h1F;
	s_box[12][12] = 8'h4B;
	s_box[12][13] = 8'hBD;
	s_box[12][14] = 8'h8B;
	s_box[12][15] = 8'h8A;

	// fourteenth row 
	s_box[13][0] = 8'h70;
	s_box[13][1] = 8'h3E;
	s_box[13][2] = 8'hB5;
	s_box[13][3] = 8'h66;
	s_box[13][4] = 8'h48;
	s_box[13][5] = 8'h03;
	s_box[13][6] = 8'hF6;
	s_box[13][7] = 8'h0E;
	s_box[13][8] = 8'h61;
	s_box[13][9] = 8'h35;
	s_box[13][10] = 8'h57;
	s_box[13][11] = 8'hB9;
	s_box[13][12] = 8'h86;
	s_box[13][13] = 8'hC1;
	s_box[13][14] = 8'h1D;
	s_box[13][15] = 8'h9E;


	//fifteenth row 
	s_box[14][0] = 8'hE1;
	s_box[14][1] = 8'hF8;
	s_box[14][2] = 8'h98;
	s_box[14][3] = 8'h11;
	s_box[14][4] = 8'h69;
	s_box[14][5] = 8'hD9;
	s_box[14][6] = 8'h8E;
	s_box[14][7] = 8'h94;
	s_box[14][8] = 8'h9B;
	s_box[14][9] = 8'h1E;
	s_box[14][10] = 8'h87;
	s_box[14][11] = 8'hE9;
	s_box[14][12] = 8'hCE;
	s_box[14][13] = 8'h55;
	s_box[14][14] = 8'h28;
	s_box[14][15] = 8'hDF;


	// fifteenth row 
	s_box[15][0] = 8'h8C;
	s_box[15][1] = 8'hA1;
	s_box[15][2] = 8'h89;
	s_box[15][3] = 8'h0D;
	s_box[15][4] = 8'hBF;
	s_box[15][5] = 8'hE6;
	s_box[15][6] = 8'h42;
	s_box[15][7] = 8'h68;
	s_box[15][8] = 8'h41;
	s_box[15][9] = 8'h99;
	s_box[15][10] = 8'h2D;
	s_box[15][11] = 8'h0F;
	s_box[15][12] = 8'hB0;
	s_box[15][13] = 8'h54;
	s_box[15][14] = 8'hBB;
	s_box[15][15] = 8'h16;
end


always@(*) 
begin

		bytes_out[7 :0 ]   = s_box [ W[7 :4] ][ W[ 3:0 ] ] ;
		bytes_out[15:8 ]   = s_box [ W[15:12]][ W[11:8 ] ] ;
		bytes_out[23:16]   = s_box [ W[23:20]][ W[19:16] ] ;
  		bytes_out[31:24]   = s_box [ W[31:28]][ W[27:24] ] ;
		bytes_out[39:32]   = s_box [ W[39:36]][ W[35:32] ] ;
		bytes_out[47:40]   = s_box [ W[47:44]][ W[43:40] ] ;
		bytes_out[55:48]   = s_box [ W[55:52]][ W[51:48] ] ;
  		bytes_out[63:56]   = s_box [ W[63:60]][ W[59:56] ] ;
		bytes_out[71:64]   = s_box [ W[71:68]][ W[67:64] ] ;
		bytes_out[79:72]   = s_box [ W[79:76]][ W[75:72] ] ;
		bytes_out[87:80]   = s_box [ W[87:84]][ W[83:80] ] ;
  		bytes_out[95:88]   = s_box [ W[95:92]][ W[91:88] ] ;
		bytes_out[103:96]  = s_box [ W[103:100]][W[99:96]] ;
		bytes_out[111:104] = s_box [ W[111:108]][W[107:104]] ;
		bytes_out[119:112] = s_box [ W[119:116]][ W[115:112] ] ;
  		bytes_out[127:120] = s_box [ W[127:124]][ W[123:120] ] ;

end
endmodule 


