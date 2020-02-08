module io_input_reg (addr,io_clk,io_read_data,in_port0,in_port1);
	input [31:0] addr;
	input io_clk;
	
	input [31:0] in_port0,in_port1;
	output [31:0] io_read_data;
	
	reg [31:0] in_reg0; // input port0
	reg [31:0] in_reg1; // input port1
	
	io_input_mux io_imput_mux2x32(in_reg0,in_reg1,addr[7:2],io_read_data);
	
	always @(posedge io_clk) 
	begin
		in_reg0 <= in_port0; // MEM192
		in_reg1 <= in_port1; // MEM196
		// more ports
	end
endmodule 