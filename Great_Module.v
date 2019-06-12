module big (input clck ,input reset ,input [127 : 0] key , message , input [63 : 0] Nonce , output reg [127:0] cipher_text/*,CTR_counter*/ ,/*output reg [1407:0] key_boxo*/output reg flag_finished );

reg [127:0] CTR_counter    ;
reg [3:0]   states         ;

// Flag for cipher_text 
reg flag ;

//________________________________________________________________________________
//modules things  - Key generation  
  //Input to every module
reg [127:0]  sub_container ;
reg [127:0] shft_container ;
reg [127:0]  mix_container ;

    // Input to every module  wires 
wire[127:0] sub_container_w   ;
assign sub_container_w  = sub_container ;

wire[127:0] shft_container_w  ;
assign shft_container_w = shft_container  ;

wire[127:0] mix_container_w ;
assign mix_container_w  = mix_container;

//Outputs 
    //Sub_Byte module output
wire[127:0] Sub_byte_w  ;
    //Shift    module output 
wire[127:0] shift_2row_w;
    //Mix col  module output 
wire[127:0] Result_w    ;
//_________________________________________________________________________________
// Key generation module 
  // inputs to the module things 
reg [127:0] old_key  ;
wire[127:0] old_key_w;
assign  old_key_w = old_key;

reg [3  :0] rounds   ;
wire[3  :0] rounds_w ;
assign  rounds_w= rounds   ;
  // output to the module things 
reg [127:0] new_key  ;
wire[127:0] new_key_w;


// Coloumn wise modules things 
// Coloumn wise for key 
  //Output key 
reg [127:0] Coloumn_wise_k ;
wire[127:0] Coloumn_wise_kw;

  //No need for input 
  
// Coloumn wise for Counter 
  //output 
wire[127:0] Coloumn_wise_cw;  
  //Input 
reg [127:0] CTR_Copy ; 

// Coloumn wise for message 
  //output
  wire [127:0] message_cw ;
  reg  [127:0] message_cw_reg;
  // No need for input cause it takes message input from the module 
  
  
// Key box module things 
  //output 
   //wire[1407:0] key_boxo_w;
   
//_________________________________________________________________________________
// Instantiating modules 

// Coloumn wise for key , Message , initialized counter
Coloumn_Wise  Coloumn_Wise (.inp_row(new_key  )    ,.out_col(Coloumn_wise_kw  ));
Coloumn_Wise  Coloumn_Wise1(.inp_row(CTR_Copy )    ,.out_col(Coloumn_wise_cw  ));
Coloumn_Wise  Coloumn_Wise2(.inp_row(message  )    ,.out_col(message_cw       ));

// Instantiation of other modules 
Sub_byte128   Sub_byte128  (.W(sub_container_w)       ,.bytes_out     (Sub_byte_w));
Mat_multtt    Matsuck      (.message(mix_container_w) ,.Result          (Result_w));   
shift_2row    shift_2row   (.data(shft_container_w)   ,.data_shifted(shift_2row_w));   
key_expansion key_expan    (.key(old_key_w),.rounds(rounds_w),.key_new(new_key_w));
//key_box       key_box      (.new_key(Coloumn_wise_k),.key_box(key_boxo_w));

//________________________________________________________________________________


// BEGINING OF THE ACTUAL CODE 

always @(posedge clck or posedge reset ) begin 
  if (reset == 1 ) begin 
    // Reseting rounds and states and flags and and and  
    states      <= 4'b1010;
    rounds      <= 4'b0000;
    flag        <= 1'b0   ;
    
    /* OLD 
    // Creating the 128 bit of the counter
    CTR_counter <= 128'd0 ;
    CTR_counter[127:64] <= Nonce ;
    CTR_counter[63 :0 ] <= 64'he004b7c5d830805a ; // To try the program but it should be 64 bit of zeros
    */
    
    // CTR_Counter after coloumn wise  
    CTR_Copy            <= 128'h0000000000000000f8f9fafbfcfdfeff ;
    CTR_Copy[127:64]    <= Nonce ;
    CTR_counter         <= Coloumn_wise_cw;
    
    // Message after coloumn wise
    message_cw_reg      <= message_cw ; 
    // Initializing the key 
    new_key   <=key ;
  end
end


always @(posedge clck) begin 
if (reset ==0 &&  (rounds < 11) ) begin
  case (states ) 
    4'b1010 : begin 
              Coloumn_wise_k <= Coloumn_wise_kw ;
              states         <= 4'b0000 ;
              end
    4'b0000 : begin  // Add round key 
     //         key_boxo       <= key_boxo_w;
              CTR_counter  <= CTR_counter ^ Coloumn_wise_k ;
              states       <= 4'b0001  ; 
              end  
         
    4'b0001 : begin  // Sub_byte           _input
$display("roound bf %b",rounds);
              if ( rounds == 10 ) begin
              rounds       <= rounds +1   ;
$display("roound %b",rounds);
              states       <= 4'b0001     ;
              end
            else begin 
              sub_container     <= CTR_counter ;
              states            <= 4'b0010;
              end
              end
    4'b0010 : begin // Sub_byte            _output  
              CTR_counter  <= Sub_byte_w  ;
              states       <= 4'b0100;
              end
    4'b0100 : begin // Shift               _input
              shft_container    <= CTR_counter ;
              states            <= 4'b0101;    
              end     
    4'b0101 : begin // Shift               _output
              CTR_counter  <= shift_2row_w;
              states       <= 4'b0110;
              end
    4'b0110 : begin // Mix                 _input
              if (rounds == 9 ) begin 
              states       <= 4'b1000  ;
              end  
            else  begin 
              mix_container    <= CTR_counter ;
              states           <= 4'b0111;
              end
              end   
    4'b0111 : begin // Mix                 _output
              CTR_counter  <= Result_w ;
              states       <= 4'b1000  ;
              end   
                
    4'b1000 : begin // ROUND KEY GENERATION BEGINS FROM HERE 
              old_key      <= new_key  ;
              rounds       <= rounds+1 ;
              $display("4'b1000 roound %b",rounds);
              states       <= 4'b1001  ;
              end
    4'b1001 : begin
              new_key      <= new_key_w;
              states       <= 4'b1010  ;
              end
      endcase 
    end
  else if ( rounds == 4'b1011 ) begin
    

    cipher_text  <= CTR_counter ^ message_cw_reg ; 
    flag_finished<= 1;
$display("cipher %x flag: ",cipher_text,flag_finished);
   end
end
endmodule