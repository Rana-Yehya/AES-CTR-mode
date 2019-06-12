import AES_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "Key_Expansion.sv"
class AES_monitor_before extends uvm_monitor;
	`uvm_component_utils(AES_monitor_before)

	uvm_analysis_port#(AES_transaction) mon_ap_before;
  virtual AES_if vif;
   
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		void'(uvm_resource_db#(virtual AES_if)::read_by_name
			(.scope("ifs"), .name("AES_if"), .val(vif)));
			
		mon_ap_before = new(.name("mon_ap_before"), .parent(this));
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		//integer state = 0;
		//integer cntr =0;

		AES_transaction AES_tx;
		AES_tx = AES_transaction::type_id::create(.name("AES_tx"), .contxt(get_full_name()));

		forever begin
			@(posedge vif.sig_clck)
			begin
				if(vif.sig_flag==1)
				begin
					AES_tx.ciphertext = vif.sig_ciphertext;
					//$display("The output of DUT :");
					//$display("%32x",vif.sig_ciphertext);
					mon_ap_before.write(AES_tx);
				end
			end
		end
	endtask: run_phase
endclass: AES_monitor_before

class AES_monitor_after extends uvm_monitor;
	`uvm_component_utils(AES_monitor_after)
	
	uvm_analysis_port#(AES_transaction) mon_ap_after;
	virtual AES_if vif;
	
	//For coverage
	AES_transaction AES_tx_cg;
	
	//For C function 
	try_key AES_doo ;
	
	byte unsigned arr1 [8 ];
	byte unsigned arr2 [16];
	byte unsigned arr3 [16];
	byte unsigned arr4 [16];
	
	//Define coverpoints
	covergroup AES_cg;
      		key_cp:     coverpoint AES_tx_cg.key;
      		message_cp: coverpoint AES_tx_cg.message;
      		nonce_cp:   coverpoint AES_tx_cg.nonce;
		cross key_cp, message_cp , nonce_cp;
	endgroup: AES_cg

	function new(string name, uvm_component parent);
		super.new(name, parent);
		AES_cg = new;
		AES_doo= new;
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	void'(uvm_resource_db#(virtual AES_if)::read_by_name
			(.scope("ifs"), .name("AES_if"), .val(vif)));
		mon_ap_after= new(.name("mon_ap_after"), .parent(this));
	endfunction: build_phase
task run_phase(uvm_phase phase);
	AES_transaction AES_tx;
		integer counter=0 ;
		bit [1:0] FSM = 2'b00;
		/*vif.sig_reset = 0;
		vif.sig_key  =128'd0;
		vif.sig_nonce=64'd0;
		vif.sig_message=128'd0;
		*/
			AES_tx = AES_transaction::type_id::create
			(.name("sa_tx"), .contxt(get_full_name()));
	  		forever begin

			@(posedge vif.sig_clck)
			begin
	       if(vif.sig_reset)
	         begin   
	           AES_tx.nonce = 64'd0;
	           AES_tx.key = 128'd0;
	           AES_tx.message = 128'd0;
	           counter +=1;
	           end
	         else if(vif.sig_flag)  
	         begin
	           AES_tx.nonce = vif.sig_nonce;
	           AES_tx.key = vif.sig_key;
	           AES_tx.message = vif.sig_message;
					  $display (" before working with c file ");
						   $display ("_________________");
		           $display ("%16x",AES_tx.nonce);
		           $display ("%32x",AES_tx.key);
		           $display ("%32x",AES_tx.message);
		           $display ("_________________");
		  
	             arr1 = '{AES_tx.nonce[63 :56 ] ,AES_tx.nonce[55 :48 ] ,AES_tx.nonce  [47 :40 ] ,AES_tx.nonce[39 :32] ,AES_tx.nonce[31:24] ,AES_tx.nonce[23:16] ,AES_tx.nonce[15:8] ,AES_tx.nonce[7 :0]}; 
	             arr2 = '{AES_tx.key  [127:120] ,AES_tx.key  [119:112] ,AES_tx.key  [111:104] ,AES_tx.key  [103:96] ,AES_tx.key  [95:88] ,AES_tx.key  [87:80] ,AES_tx.key  [79:72] ,AES_tx.key  [71:64] ,AES_tx.key  [63:56] ,AES_tx.key  [55:48],AES_tx.key  [47:40],AES_tx.key  [39:32],AES_tx.key  [31:24],AES_tx.key  [23:16],AES_tx.key  [15:8],AES_tx.key  [7:0]}; 
	             arr3 = '{AES_tx.message  [127:120] ,AES_tx.message  [119:112] ,AES_tx.message  [111:104] ,AES_tx.message  [103:96] ,AES_tx.message  [95:88] ,AES_tx.message  [87:80] ,AES_tx.message  [79:72] ,AES_tx.message  [71:64] ,AES_tx.message  [63:56] ,AES_tx.message  [55:48],AES_tx.message  [47:40],AES_tx.message  [39:32],AES_tx.message  [31:24],AES_tx.message  [23:16],AES_tx.message  [15:8],AES_tx.message  [7:0]}; 
						   $display ("%p",arr1);
						   AES_tx.ciphertext = AES_doo.start(arr1,arr2,arr3);
						   $display("_________________________________");
					     $display("Monitor AFTER finished and the result is :"); 
						   $display ("%32x",AES_tx.ciphertext);  
						   $display("_________________________________");
						   AES_tx_cg = AES_tx;
		
	
              //Coverage
		           AES_cg.sample();

             // Send transaction to analysis port
               mon_ap_after.write(AES_tx);
               
				  end
				end
				
				end     
				vif.sig_flag=1'b0;
				endtask: run_phase
				
endclass: AES_monitor_after
