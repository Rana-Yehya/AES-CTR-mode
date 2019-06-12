import AES_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
	
class AES_configuration extends uvm_object;
	`uvm_object_utils(AES_configuration)

	function new(string name = "");
		super.new(name);
	endfunction: new
endclass: AES_configuration
