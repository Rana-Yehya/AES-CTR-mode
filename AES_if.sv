
interface AES_if;
	logic		sig_clck;
	logic		sig_reset;
	logic[127:0]	sig_key;
	logic[63 :0]	sig_nonce;
	logic[127:0] sig_message;

	logic[127:0]	sig_ciphertext;
	logic      sig_flag;
endinterface: AES_if