module ke (input [127:0] key,input [3:0] rounds, output reg [127:0] key_new) ;
   
  // Sub_byte module output 
  wire [31:0] SB_output_Continues ;
  reg  [31:0] SB_output_Procedural;
  wire [31:0] W3_Rotated;
  assign W3_Rotated [31:0] = { key[23 : 0] , key [31 : 24] };


  //Instantiating Sub_byte
  Sub_byte sub ( .W(W3_Rotated) , .Wi(SB_output_Continues) );
  
  // Loop variables 
  integer i;
  // Filling R_Con 
  reg [31:0] R_con  [10:1];
   
  
initial begin 
  R_con[1 ] = 32'h01000000;
  R_con[2 ] = 32'h02000000;
  R_con[3 ] = 32'h04000000;
  R_con[4 ] = 32'h08000000;
  R_con[5 ] = 32'h10000000;
  R_con[6 ] = 32'h20000000;
  R_con[7 ] = 32'h40000000;
  R_con[8 ] = 32'h80000000;
  R_con[9 ] = 32'h1B000000;
  R_con[10] = 32'h36000000;
end

always @(*) begin 
    //for (j=0 ; j<32 ; j++ )
  // Wire to register 
    SB_output_Procedural<= SB_output_Continues;
  // Finding the value of WO
    key_new [127 : 96 ] = key [127 :96] ^ SB_output_Procedural ^ R_con [rounds] ;
    
  
  // Finding the value of W1,W2,W3
  for (i=95 ; i > -1 ; i=i-1) begin
    key_new [i] = key[i] ^ key_new[i+32] ;
    end  
    /*
    if (i==-1)
      i= 95;
      */
end
/*
//always @(*)begin
  
  for (j=0 ; j<32 ; j++ )
  // Wire to register 
    SB_output_Procedural <= SB_output_Continues;
  // Finding the value of WO
    key_new [127 : 96 ] = container [127 :96] ^ SB_output_Procedural ^ R_con [rounds] ;
    
  
  // Finding the value of W1,W2,W3
  for (i=95 ; i > -1 ; i=i-1) begin
    key_new [i] = container[i] ^ key_new[i+32] ;
 // end
//end*/

endmodule 
