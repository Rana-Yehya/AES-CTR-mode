module shift( 
  input wire [127:0] data,
	input wire enable,
  output reg [127:0] data_shifted, 
output reg shift_done
);
reg[127:0] data_next;
reg[7:0] A [3:0][3:0];
reg[7:0] B [3:0][3:0];
always@(posedge clk )
begin
	if(reset)
	begin
	shift_done <= 1'b0;
	data_shifted <=128'd0;
	end
	else
	begin
	data_shifted <=data_next;
	shift_done <= shift_done;
	end
end 



always@(data)
begin 
if(enable)
begin
  {A[0][0],A[0][1],A[0][2],A[0][3],A[1][0],A[1][1],A[1][2],A[1][3],
   A[2][0],A[2][1],A[2][2],A[2][3],A[3][0],A[3][1],A[3][2],A[3][3]}= data;

  {B[0][0],B[0][1],B[0][2],B[0][3],B[1][0],B[1][1],B[1][2],B[1][3],
   B[2][0],B[2][1],B[2][2],B[2][3],B[3][0],B[3][1],B[3][2],B[3][3]}= 128'd0 ;

  B[0][0]=A[0][0];  //first row shifting
  B[0][1]=A[0][1];
  B[0][2]=A[0][2];
  B[0][3]=A[0][3];

  B[1][0]=A[1][1]; //second row shifting 
  B[1][1]=A[1][2];
  B[1][2]=A[1][3];
  B[1][3]=A[1][0];
  
  B[2][0]=A[2][2]; //third row shifting
  B[2][1]=A[2][3];
  B[2][2]=A[2][0];
  B[2][3]=A[2][1]; 
 
  B[3][0]=A[3][3]; //fourth row shifiting 
  B[3][1]=A[3][0];
  B[3][2]=A[3][1];
  B[3][3]=A[3][2];


   data_next = {B[0][0],B[0][1],B[0][2],B[0][3],B[1][0],B[1][1],B[1][2],B[1][3],
   B[2][0],B[2][1],B[2][2],B[2][3],B[3][0],B[3][1],B[3][2],B[3][3]} ; 
shift_done = 1'b1;
end
else
begin
shift_done = 1'b0;
data_next = 128'd0;
end
end 
endmodule 
