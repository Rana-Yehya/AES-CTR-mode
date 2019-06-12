import AES_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
	
class AES_transaction extends uvm_sequence_item;
	rand bit[127:0] key;
	rand bit[127:0] message;
	rand bit[63 :0] nonce;

	bit [127:0] ciphertext;
/*
	constraint data { key dist {128'd0 :=1 ,[128'd2 : 128'h0000eeeeaaaabbbb]:=1 ,128'hffffffffffffffff:=1};
	                  message dist {128'd0 :=1 ,[128'd2 : 128'h0000eeeeaaaabbbb]:=1 ,128'hffffffffffffffff:=1};
	                  nonce   dist {64'd0  :=1 ,[64'd2  : 64'h0000eeee]:=1 ,64'hffffffff:=1};}         
*/
	function new(string name = "");
		super.new(name);
	endfunction: new

	`uvm_object_utils_begin(AES_transaction)
		`uvm_field_int(key, UVM_ALL_ON)
		`uvm_field_int(message, UVM_ALL_ON)
		`uvm_field_int(nonce, UVM_ALL_ON)
		`uvm_field_int(ciphertext, UVM_ALL_ON)
	`uvm_object_utils_end
endclass: AES_transaction

class AES_sequence extends uvm_sequence#(AES_transaction);
	`uvm_object_utils(AES_sequence)
  
  int i=0;
  
	function new(string name = "");
		super.new(name);
	endfunction: new

	task body();
		AES_transaction AES_tx;
		
		repeat(2) begin // To be back to 15
		AES_tx = AES_transaction::type_id::create(.name("AES_tx"), .contxt(get_full_name()));
    
    i++;
    $display ("Value of repetition is  %d",i);
		start_item(AES_tx);
		assert(AES_tx.randomize());
		//`uvm_info("AES_sequence", AES_tx.sprint(), UVM_LOW);
		finish_item(AES_tx);
		$display("End");
		end
	endtask: body
endclass: AES_sequence

typedef uvm_sequencer#(AES_transaction) AES_sequencer;