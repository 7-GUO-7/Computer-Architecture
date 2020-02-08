module sc_datamem (addr,datain,dataout,we,clock,mem_clk,dmem_clk,clrn,
				   hex0,hex1,hex2,hex3,hex4,hex5,
				   in_port0,in_port1,
				   mem_dataout,io_read_data);
	input [31:0] addr;
	input [31:0] datain;
	input we,clock,mem_clk,clrn;
	input [31:0] in_port0,in_port1;

	output [31:0] dataout;
	output dmem_clk;
	//output [31:0] out_port0,out_port1;
	output [6:0] hex0,hex1,hex2,hex3,hex4,hex5;
	output [31:0] mem_dataout;
	output [31:0] io_read_data;
	
       
	wire [31:0] dataout;

	wire write_enable;
	wire wrire_datamem_enable;
	wire [31:0] mem_dataout;
		
	assign dmem_clk = mem_clk & ~clock ; //注意
	assign write_enable = we & ~clock; //注意
	assign write_datamem_enable = write_enable & ( ~ addr[7]); //注意
	assign write_io_output_reg_enable = write_enable & ( addr[7]); //注意

	mux2x32 mem_io_dataout_mux(mem_dataout,io_read_data,addr[7],dataout);
	// module mux2x32 (a0,a1,s,y);

	// when address[7]=0, means the access is to the datamem.
	// that is, the address space of datamem is from 000000 to 011111 word(4 bytes)

	// store datain into memory (last period)
	lpm_ram_dq_dram dram(addr[6:2],dmem_clk,datain,write_datamem_enable,mem_dataout );

	// when address[7]=1, means the access is to the I/O space.
	// that is, the address space of I/O is from 100000 to 111111 word(4 bytes)
	io_output_reg io_output_regx2 (addr,datain,write_io_output_reg_enable,dmem_clk,clrn,hex0,hex1,hex2,hex3,hex4,hex5);
	// module io_output_reg (addr,datain,write_io_enable,io_clk,clrn,hex4,hex5,hex6,hex7 );
	
	io_input_reg io_input_regx2(addr,dmem_clk,io_read_data,in_port0,in_port1);
	// module io_input_reg (addr,io_clk,io_read_data,in_port0,in_port1);

endmodule 