module r_con (input [3:0] i , output reg [31:0] r_con );
  
  always @(*)begin
    case (i)
      1 :r_con <= 32'h01000000;
      2 :r_con <= 32'h02000000;
      3 :r_con <= 32'h04000000;
      4 :r_con <= 32'h08000000;
      5 :r_con <= 32'h10000000;
      6 :r_con <= 32'h20000000;
      7 :r_con <= 32'h40000000;
      8 :r_con <= 32'h80000000;
      9 :r_con <= 32'h1B000000;
      10:r_con <= 32'h36000000;
    endcase
  end
endmodule 
