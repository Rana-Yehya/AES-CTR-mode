module Mix_Coulmn55 (input [7:0] inp1,inp2 , output [7:0] out ) ;

reg arr1    [7:0] ; 
reg arr2    [7:0] ;

reg arr3    [14:0];

reg red_mod [8:0] ;

// Loop variables
integer i,j,k,m,n ; 

always @(*) begin 
	{arr1[7],arr1[6],arr1[5],arr1[4],arr1[3],arr1[2],arr1[1],arr1[0]} <= inp1 ;

	{arr2[7],arr2[6],arr2[5],arr2[4],arr2[3],arr2[2],arr2[1],arr2[0]} <= inp2 ;
  {arr3[14],arr3[13],arr3[12],arr3[11],arr3[10],arr3[9],arr3[8],arr3[7],arr3[6],arr3[5],arr3[4],arr3[3],arr3[2],arr3[1],arr3[0]} = 14'h00;
	
	{red_mod [8] , red_mod [7] ,red_mod [6],red_mod [5],red_mod [4],red_mod [3],red_mod [2],red_mod [1],red_mod [0] } =9'b100011011;
      // i=1'b0;
      // j=1'b0;
	for (i=7 ; i>-1 ; i=i-1) begin 
	  for (j=7 ; j>-1 ; j=j-1 ) begin 
		if ((arr1[i] == 1) &&(arr2[j] ==1))begin
			if ( arr3[i+j] == 1 )
				arr3[i+j] =0;
			else
				arr3[i+j] =1;
		end
		else
			arr3 [i+j] = arr3[i+j];
	   end
	end
	
	n=8;
	
	for (k=14 ; k>-1 ; k=k-1) begin  
	  if ( arr3[k] ==1 && {arr3[14],arr3[13],arr3[12],arr3[11],arr3[10],arr3[9],arr3[8],arr3[7],arr3[6],arr3[5],arr3[4],arr3[3],arr3[2],arr3[1],arr3[0]} > 8'b11111111 ) 
		  for (m=k; m>k-9 ; m=m-1 ) begin
		   arr3[m] = arr3[m] ^ red_mod[n];
		   if(n==0)
			   n=8;
			 else
			   n=n-1;
		  end
	end
	end

	assign out = {arr3[7],arr3[6],arr3[5],arr3[4],arr3[3],arr3[2],arr3[1],arr3[0]};
endmodule 

