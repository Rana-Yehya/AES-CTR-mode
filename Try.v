module Mat_multtt( 
    
    input [127:0] message,
    output reg [127:0] Result 
);   
 
    reg [7:0] A1 [0:3][0:3];
    reg [7:0] r_con [0:3][0:3];
    reg [7:0] Res1 [0:3][0:3]; 
    integer i,j,m;
    
    reg [7:0] container ;
initial begin 

r_con [0][0]=8'h2;
r_con [0][1]=8'h3;
r_con [0][2]=8'h1;
r_con [0][3]=8'h1;

r_con [1][0]=8'h1;
r_con [1][1]=8'h2;
r_con [1][2]=8'h3;
r_con [1][3]=8'h1;

r_con [2][0]=8'h1;
r_con [2][1]=8'h1;
r_con [2][2]=8'h2;
r_con [2][3]=8'h3;

r_con [3][0]=8'h3;
r_con [3][1]=8'h1;
r_con [3][2]=8'h1;
r_con [3][3]=8'h2;
end 
    always@ (message )
    begin

        {A1[0][0],A1[0][1],A1[0][2],A1[0][3],A1[1][0],A1[1][1],A1[1][2],A1[1][3],
         A1[2][0],A1[2][1],A1[2][2],A1[2][3],A1[3][0],A1[3][1],A1[3][2],A1[3][3]} = message;
        i = 0;
        j = 0;
        m = 0;
        {Res1[0][0],Res1[0][1],Res1[0][2],Res1[0][3],Res1[1][0],Res1[1][1],Res1[1][2],Res1[1][3],
         Res1[2][0],Res1[2][1],Res1[2][2],Res1[2][3],Res1[3][0],Res1[3][1],Res1[3][2],Res1[3][3]} = 128'd0;
       
        for(i=0;i < 4;i=i+1)begin
            for(j=0;j < 4;j=j+1)begin
                for(m=0;m < 4;m=m+1)begin
                  case ( r_con [i][m] ) 
                    8'h01 : Res1[i][j] = Res1[i][j] ^ A1[m][j] ;
                    8'h02 : begin
                            container = A1[m][j] ;
                            if (container [7] == 1'b0 )
                                Res1[i][j] = Res1[i][j] ^ (container<<1);
                            else
                                Res1[i][j] = Res1[i][j] ^ (container<<1) ^8'h1B;
                            end
                    default:begin
                            container = A1[m][j] ;
                            if (container [7] == 1'b0 )
                                Res1[i][j] = Res1[i][j] ^ (container<<1) ^ container;
                            else
                                Res1[i][j] = Res1[i][j] ^ (container<<1) ^8'h1B ^ container;
                            
                      
                      
                            end
                    endcase
     end 
   end
 end
        Result = {Res1[0][0],Res1[0][1],Res1[0][2],Res1[0][3],Res1[1][0],Res1[1][1],Res1[1][2],Res1[1][3],
         Res1[2][0],Res1[2][1],Res1[2][2],Res1[2][3],Res1[3][0],Res1[3][1],Res1[3][2],Res1[3][3]};
end
endmodule



