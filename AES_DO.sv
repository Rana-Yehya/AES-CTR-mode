class AES_do ; 
  
  typedef byte staty [][];
  typedef byte container [] ;
  typedef bit [127:0] shity ;
  typedef bit [63 :0] socute;
  //typedef byte fourbyfour[][];
  
  shity one ;
  
  shity shit ;
  container contain ;
  
  socute sobox;
   
  byte nonce      [8 ]; 
  byte message    [16];
  byte ciphertext [16];

byte  in[16], out[16], state[4][4];

parameter Nb= 4 ;
int Nr=0;
int Nk=0;

byte RoundKey[240];
byte Key[16];

byte box;

byte temp [16];

//typedef byte bytestream_t[16];

byte Rcon[255] = {
    8'h8d, 8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80, 8'h1b, 8'h36, 8'h6c, 8'hd8, 8'hab, 8'h4d, 8'h9a,
    8'h2f, 8'h5e, 8'hbc, 8'h63, 8'hc6, 8'h97, 8'h35, 8'h6a, 8'hd4, 8'hb3, 8'h7d, 8'hfa, 8'hef,8'hc5, 8'h91, 8'h39,
    8'h72, 8'he4, 8'hd3, 8'hbd, 8'h61, 8'hc2, 8'h9f, 8'h25, 8'h4a, 8'h94, 8'h33, 8'h66, 8'hcc, 8'h83, 8'h1d, 8'h3a,
    8'h74, 8'he8, 8'hcb, 8'h8d, 8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80, 8'h1b, 8'h36, 8'h6c, 8'hd8,
    8'hab, 8'h4d, 8'h9a, 8'h2f, 8'h5e, 8'hbc, 8'h63, 8'hc6, 8'h97, 8'h35, 8'h6a, 8'hd4, 8'hb3, 8'h7d, 8'hfa, 8'hef,
    8'hc5, 8'h91, 8'h39, 8'h72, 8'he4, 8'hd3, 8'hbd, 8'h61, 8'hc2, 8'h9f, 8'h25, 8'h4a, 8'h94, 8'h33, 8'h66, 8'hcc,
    8'h83, 8'h1d, 8'h3a, 8'h74, 8'he8, 8'hcb, 8'h8d, 8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80, 8'h1b,
    8'h36, 8'h6c, 8'hd8, 8'hab, 8'h4d, 8'h9a, 8'h2f, 8'h5e, 8'hbc, 8'h63, 8'hc6, 8'h97, 8'h35, 8'h6a, 8'hd4, 8'hb3,
    8'h7d, 8'hfa, 8'hef, 8'hc5, 8'h91, 8'h39, 8'h72, 8'he4, 8'hd3, 8'hbd, 8'h61, 8'hc2, 8'h9f, 8'h25, 8'h4a, 8'h94,
    8'h33, 8'h66, 8'hcc, 8'h83, 8'h1d, 8'h3a, 8'h74, 8'he8, 8'hcb, 8'h8d, 8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20,
    8'h40, 8'h80, 8'h1b, 8'h36, 8'h6c, 8'hd8, 8'hab, 8'h4d, 8'h9a, 8'h2f, 8'h5e, 8'hbc, 8'h63, 8'hc6, 8'h97, 8'h35,
    8'h6a, 8'hd4, 8'hb3, 8'h7d, 8'hfa, 8'hef, 8'hc5, 8'h91, 8'h39, 8'h72, 8'he4, 8'hd3, 8'hbd, 8'h61, 8'hc2, 8'h9f,
    8'h25, 8'h4a, 8'h94, 8'h33, 8'h66, 8'hcc, 8'h83, 8'h1d, 8'h3a, 8'h74, 8'he8, 8'hcb, 8'h8d, 8'h01, 8'h02, 8'h04,
    8'h08, 8'h10, 8'h20, 8'h40, 8'h80, 8'h1b, 8'h36, 8'h6c, 8'hd8, 8'hab, 8'h4d, 8'h9a, 8'h2f, 8'h5e, 8'hbc, 8'h63,
    8'hc6, 8'h97, 8'h35, 8'h6a, 8'hd4, 8'hb3, 8'h7d, 8'hfa, 8'hef, 8'hc5, 8'h91, 8'h39, 8'h72, 8'he4, 8'hd3, 8'hbd,
    8'h61, 8'hc2, 8'h9f, 8'h25, 8'h4a, 8'h94, 8'h33, 8'h66, 8'hcc, 8'h83, 8'h1d, 8'h3a, 8'h74, 8'he8, 8'hcb  };
    
    byte sbox[256] =   {
    //0     1      2      3       4      5      6     7      8      9       A      B     C      D       E     F
    8'h63, 8'h7c, 8'h77, 8'h7b, 8'hf2, 8'h6b, 8'h6f, 8'hc5, 8'h30, 8'h01, 8'h67, 8'h2b, 8'hfe, 8'hd7, 8'hab, 8'h76, //0
    8'hca, 8'h82, 8'hc9, 8'h7d, 8'hfa, 8'h59, 8'h47, 8'hf0, 8'had, 8'hd4, 8'ha2, 8'haf, 8'h9c, 8'ha4, 8'h72, 8'hc0, //1
    8'hb7, 8'hfd, 8'h93, 8'h26, 8'h36, 8'h3f, 8'hf7, 8'hcc, 8'h34, 8'ha5, 8'he5, 8'hf1, 8'h71, 8'hd8, 8'h31, 8'h15, //2
    8'h04, 8'hc7, 8'h23, 8'hc3, 8'h18, 8'h96, 8'h05, 8'h9a, 8'h07, 8'h12, 8'h80, 8'he2, 8'heb, 8'h27, 8'hb2, 8'h75, //3
    8'h09, 8'h83, 8'h2c, 8'h1a, 8'h1b, 8'h6e, 8'h5a, 8'ha0, 8'h52, 8'h3b, 8'hd6, 8'hb3, 8'h29, 8'he3, 8'h2f, 8'h84, //4
    8'h53, 8'hd1, 8'h00, 8'hed, 8'h20, 8'hfc, 8'hb1, 8'h5b, 8'h6a, 8'hcb, 8'hbe, 8'h39, 8'h4a, 8'h4c, 8'h58, 8'hcf, //5
    8'hd0, 8'hef, 8'haa, 8'hfb, 8'h43, 8'h4d, 8'h33, 8'h85, 8'h45, 8'hf9, 8'h02, 8'h7f, 8'h50, 8'h3c, 8'h9f, 8'ha8, //6
    8'h51, 8'ha3, 8'h40, 8'h8f, 8'h92, 8'h9d, 8'h38, 8'hf5, 8'hbc, 8'hb6, 8'hda, 8'h21, 8'h10, 8'hff, 8'hf3, 8'hd2, //7
    8'hcd, 8'h0c, 8'h13, 8'hec, 8'h5f, 8'h97, 8'h44, 8'h17, 8'hc4, 8'ha7, 8'h7e, 8'h3d, 8'h64, 8'h5d, 8'h19, 8'h73, //8
    8'h60, 8'h81, 8'h4f, 8'hdc, 8'h22, 8'h2a, 8'h90, 8'h88, 8'h46, 8'hee, 8'hb8, 8'h14, 8'hde, 8'h5e, 8'h0b, 8'hdb, //9
    8'he0, 8'h32, 8'h3a, 8'h0a, 8'h49, 8'h06, 8'h24, 8'h5c, 8'hc2, 8'hd3, 8'hac, 8'h62, 8'h91, 8'h95, 8'he4, 8'h79, //A
    8'he7, 8'hc8, 8'h37, 8'h6d, 8'h8d, 8'hd5, 8'h4e, 8'ha9, 8'h6c, 8'h56, 8'hf4, 8'hea, 8'h65, 8'h7a, 8'hae, 8'h08, //B
    8'hba, 8'h78, 8'h25, 8'h2e, 8'h1c, 8'ha6, 8'hb4, 8'hc6, 8'he8, 8'hdd, 8'h74, 8'h1f, 8'h4b, 8'hbd, 8'h8b, 8'h8a, //C
    8'h70, 8'h3e, 8'hb5, 8'h66, 8'h48, 8'h03, 8'hf6, 8'h0e, 8'h61, 8'h35, 8'h57, 8'hb9, 8'h86, 8'hc1, 8'h1d, 8'h9e, //D
    8'he1, 8'hf8, 8'h98, 8'h11, 8'h69, 8'hd9, 8'h8e, 8'h94, 8'h9b, 8'h1e, 8'h87, 8'he9, 8'hce, 8'h55, 8'h28, 8'hdf, //E
    8'h8c, 8'ha1, 8'h89, 8'h0d, 8'hbf, 8'he6, 8'h42, 8'h68, 8'h41, 8'h99, 8'h2d, 8'h0f, 8'hb0, 8'h54, 8'hbb, 8'h16 }; //F

 

 virtual function void KeyExpansion();
    int i,j;
    byte temp[4],k;
    // The first round key is the key itself.
    for(i=0;i<Nk;i++)
    begin
        RoundKey[i*4]=Key[i*4];
        RoundKey[i*4+1]=Key[i*4+1];
        RoundKey[i*4+2]=Key[i*4+2];
        RoundKey[i*4+3]=Key[i*4+3];
    end
    // All other round keys are found from the previous round keys.
    while (i < (Nb * (Nr+1)))
    begin
        for(j=0;j<4;j++)
        begin
            temp[j]=RoundKey[(i-1) * 4 + j];
        end
        if (i % Nk == 0)
        begin
            // This function rotates the 4 bytes in a word to the left once.
            // [a0,a1,a2,a3] becomes [a1,a2,a3,a0]
            // Function RotWord()
            begin
                k = temp[0];
                temp[0] = temp[1];
                temp[1] = temp[2];
                temp[2] = temp[3];
                temp[3] = k;
          end
            // SubWord() is a function that takes a four-byte input word and
            // applies the S-box to each of the four bytes to produce an output word.
            // Function Subword()
            begin
                temp[0]=sbox[temp[0]];
                temp[1]=sbox[temp[1]];
                temp[2]=sbox[temp[2]];
                temp[3]=sbox[temp[3]];
          end
            temp[0] =  temp[0] ^ Rcon[i/Nk];
       end
        else if (Nk > 6 && i % Nk == 4)
        begin
            // Function Subword()
            begin
                temp[0]=sbox[temp[0]];
                temp[1]=sbox[temp[1]];
                temp[2]=sbox[temp[2]];
                temp[3]=sbox[temp[3]];
           end
       end
        RoundKey[i*4+0] = RoundKey[(i-Nk)*4+0] ^ temp[0];
        RoundKey[i*4+1] = RoundKey[(i-Nk)*4+1] ^ temp[1];
        RoundKey[i*4+2] = RoundKey[(i-Nk)*4+2] ^ temp[2];
        RoundKey[i*4+3] = RoundKey[(i-Nk)*4+3] ^ temp[3];
        i++;
   end 
endfunction : KeyExpansion;
  
virtual function void AddRoundKey(int round);
begin
    int i,j;
    for(i=0;i<4;i++)
    begin
        for(j=0;j<4;j++)
        begin
            state[j][i] ^= RoundKey[round * Nb * 4 + i * Nb + j];
      end
  end
end
endfunction : AddRoundKey;

virtual function void SubBytes();
begin
    int i,j;
    for(i=0;i<4;i++)
    begin
        for(j=0;j<4;j++)
        begin
            sobox = socute'(state[i][j]);
            //$display ("%2x",sobox);
            sobox = sbox[{sobox[7:4],sobox[3:0]}];
            //$display ("%2x",sobox);
            state[i][j] = byte'(sobox);
            //$display ("%p",state);
            
            //$display ("%16x",state[i][j]);
            //state[i][j] = sbox[state[i][j]];
            //$display ("%16x",state[i][j]);
      end
  end
  //$display("%p",state);
end
endfunction : SubBytes;

function void ShiftRows();
begin
    byte temp;
    // Rotate first row 1 columns to left
    temp=state[1][0];
    state[1][0]=state[1][1];
    state[1][1]=state[1][2];
    state[1][2]=state[1][3];
    state[1][3]=temp;
    // Rotate second row 2 columns to left
    temp=state[2][0];
    state[2][0]=state[2][2];
    state[2][2]=temp;
    temp=state[2][1];
    state[2][1]=state[2][3];
    state[2][3]=temp;
    // Rotate third row 3 columns to left
    temp=state[3][0];
    state[3][0]=state[3][3];
    state[3][3]=state[3][2];
    state[3][2]=state[3][1];
    state[3][1]=temp;
end
endfunction : ShiftRows;


function void MixColumns();
begin
    int i;
    byte Tmp,Tm,t;
    for(i=0;i<4;i++)
    begin
        t=state[0][i];
        Tmp= state[0][i] ^ state[1][i] ^ state[2][i] ^ state[3][i] ;
        Tm = state[0][i] ^ state[1][i] ; Tm = xtime(Tm); state[0][i] ^= Tm ^ Tmp ;
        Tm = state[1][i] ^ state[2][i] ; Tm = xtime(Tm); state[1][i] ^= Tm ^ Tmp ;
        Tm = state[2][i] ^ state[3][i] ; Tm = xtime(Tm); state[2][i] ^= Tm ^ Tmp ;
        Tm = state[3][i] ^ t ; Tm = xtime(Tm); state[3][i] ^= Tm ^ Tmp ;
  end
end
endfunction : MixColumns ;

function void Cipher();
begin
    int i,j,round=0;
    for(i=0;i<4;i++)
    begin
        for(j=0;j<4;j++)
        begin
            state[j][i] = in[i*4 + j];
        end
    end
    // Add the First round key to the state before starting the rounds.
    AddRoundKey(0);
    // There will be Nr rounds.
    // The first Nr-1 rounds are identical.
    // These Nr-1 rounds are executed in the loop below.
    for(round=1;round<Nr;round++)
    begin
        SubBytes();
        ShiftRows();
        MixColumns();
        AddRoundKey(round);
    end
    // The last round is given below.
    // The MixColumns function is not here in the last round.
    SubBytes();
    ShiftRows();
    AddRoundKey(Nr);
    // The encryption process is over.
    // Copy the state array to output array.
    for(i=0;i<4;i++)
    begin
        for(j=0;j<4;j++)
        begin
            
            out[i*4+j]=state[j][i] ^ message[i*4+j];
        end        
   end
             //$display ("out is %p",out); 
             contain =out;
             //$display ("contain is %p",contain);
             shit = shity'(contain);
             //$display ("shit is %16x",shit);
             
             //$display ("ROUND KEY IS %p",RoundKey);
  
end
endfunction : Cipher;

function void start (socute arr1 , shity arr2 , shity arr3 );
begin

    int i;
    Nr = 128 ;  // Cause we are working like this 

    Nk = Nr / 32;
    Nr = Nk + 6;

    temp = {arr1[63 :56 ] ,arr1[55 :48 ] ,arr1[47 :40 ] ,arr1[39 :32] ,arr1[31:24] ,arr1[23:16] ,arr1[15:8 ] ,arr1[7 :0] ,8'hf8  ,8'hf9  ,8'hfa  ,8'hfb  ,8'hfc  ,8'hfd  ,8'hfe  ,8'hff};


    Key =container'(arr2);
    message =container'(arr3);
    /*
    for(i=0;i<Nk*4;i++)
    begin
        in[i] =temp[i];
        Key[i]=arr2[i];
        message[i]=arr3[i];
   end
   */
    
    one = shity'(Key);
    Key = container'(one);
    //$display("%16x",one);
    //$display("%p",in);
    //$display("%p",Key);
    //$display("%p",message);
    
    KeyExpansion();
    
    Cipher();
end
endfunction : start;


function shity finish (shity arr );
  return shit;
endfunction :finish ;

function byte xtime (byte x) ;
 // $display ("before :%2x",x);
  x= ((x<<1) ^ (((x>>7) & 1) * 8'h1b)) ;
 // $display ("After  :%2x",x);
  return x;
 endfunction : xtime;

endclass : AES_do ;
