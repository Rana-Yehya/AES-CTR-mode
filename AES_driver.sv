import AES_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
	
class AES_driver extends uvm_driver#(AES_transaction);
	`uvm_component_utils(AES_driver)

	virtual AES_if vif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		void'(uvm_resource_db#(virtual AES_if)::read_by_name
			(.scope("ifs"), .name("AES_if"), .val(vif)));
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		drive();
	endtask: run_phase

	virtual task drive();
		AES_transaction AES_tx;
		integer states   = 0 , rounds =0,counter=0 ;
		bit [1:0] FSM = 2'b00;
		vif.sig_reset = 0;
		vif.sig_key  =128'd0;
		vif.sig_nonce=64'd0;
		vif.sig_message=128'd0;
		
		forever begin
			if(counter==0)  // instead of counter = 0 it will be reset = 1 cause that's where our design begins
			begin
				seq_item_port.get_next_item(AES_tx); // Taking the next randmozied set of values from the sequencer 
				$display("new sq %x %x ",AES_tx.key,AES_tx.message);
				//`uvm_info("sa_driver", sa_tx.sprint(), UVM_LOW);
			end

			@(posedge vif.sig_clck)
			begin
				if(counter<2)
				begin
				  if (counter ==1) begin
					vif.sig_reset    = 1'b0;
					FSM =2'b01;
					counter +=1;
					end
					else if(counter == 0) begin
					 vif.sig_reset   = 1'b1;
					     
					 $display (" what is inside your driver" );
				   $display ("_________________");
		       $display ("%16x",AES_tx.nonce);
		       $display ("%32x",AES_tx.key);
		       $display ("%32x",AES_tx.message);
		       $display ("_________________");
				   vif.sig_key     = AES_tx.key;
				   vif.sig_message = AES_tx.message;
				   vif.sig_nonce   = AES_tx.nonce;
				   counter +=1;
				  end
				end
				if (counter ==2) begin
				case(FSM)
					2'b01: begin
						if (rounds == 10 ) begin // Number is not accurate 
							states+=1;
							if (states == 2 ) 
							begin
							 states =0;
							 rounds +=1;
							end
					    end	    
					   else if (rounds <=9 ) begin
						   states +=1 ;
						  if (states == 10) begin
						   states  =0;
						   rounds +=1;
						   end
               end
						else begin
						  states +=1 ;
						  if (states == 3 ) begin
						  $display("____________________");
						  $display("Sequence finished");
			        $display("____________________");
			        
						  seq_item_port.item_done(); 
						  rounds =  0 ;
						  FSM = 2'b00 ;	  
						  counter =0;
						  states =  0 ;
						end
            end
            end
				endcase
			 end
			end
		end
	endtask: drive
endclass: AES_driver