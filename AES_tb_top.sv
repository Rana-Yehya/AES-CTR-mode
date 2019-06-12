`include "AES_pkg.sv"
`include "Great_Module.v"
`include "AES_if.sv"
	
module AES_tb_top;
   	import uvm_pkg::*;
    import AES_pkg::*;
	
	//Interface declaration
  AES_if vif();
	
  
	//Connects the Interface to the DUT
	big dut(.clck(vif.sig_clck),
			.reset(vif.sig_reset),
			.key(vif.sig_key),
			.Nonce(vif.sig_nonce),
			.message(vif.sig_message),
			.cipher_text(vif.sig_ciphertext),
			.flag(vif.sig_flag));

	initial begin
		//Registers the Interface in the configuration block so that other
		//blocks can use it
		uvm_resource_db#(virtual AES_if)::set
			(.scope("ifs"), .name("AES_if"), .val(vif));
    
		//Executes the test
		run_test();
	end

	//Variable initialization
	initial begin
		vif.sig_clck <= 1'b0;
	end

//Clock generation
	always
		#5 vif.sig_clck = ~vif.sig_clck;
endmodule
