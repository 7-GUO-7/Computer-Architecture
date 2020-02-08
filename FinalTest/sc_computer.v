/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer (resetn,clk,pc,inst,aluout,mem_dataout,io_read_data,dataout,
					imem_clk,dmem_clk,mem_clk,clock,
					io0,io1,io2,io3,io4,io5,io6,io7,io8,io9,
					hex0,hex1,hex2,hex3,hex4,hex5,
					data);
   
	input 		  resetn,clk;
	input  		  io0,io1,io2,io3,io4,io5,io6,io7,io8,io9;
	//reg  [5:0]  io_input_0, io_input_1;
	output [31:0] pc,inst,aluout,mem_dataout,io_read_data,dataout;
	output        imem_clk,dmem_clk;
	output		  mem_clk, clock;
	output [6:0]  hex0,hex1,hex2,hex3,hex4,hex5;
	output [31:0] data;
   wire  [5:0]  io_input_0, io_input_1;

	wire   [31:0] in_port0,in_port1;
	wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.

	assign io_input_0[0]=io0;
	assign io_input_0[1]=io1;
	assign io_input_0[2]=io2;
	assign io_input_0[3]=io3;
	assign io_input_0[4]=io4;
	assign io_input_1[0]=io5;
	assign io_input_1[1]=io6;
	assign io_input_1[2]=io7;
	assign io_input_1[3]=io8;
	assign io_input_1[4]=io9;

	assign in_port0 = {26'b0, io_input_0};
	assign in_port1 = {26'b0, io_input_1};

	clockdiv clocker (clk,mem_clk,clock);
	sc_cpu cpu (clock,resetn,inst,dataout,pc,wmem,aluout,data);          // CPU module.
	sc_instmem  imem (pc,inst,clock,mem_clk,imem_clk);                  // instruction memory.
	sc_datamem  dmem (aluout,data,dataout,wmem,clock,mem_clk,dmem_clk,resetn,
					  hex0,hex1,hex2,hex3,hex4,hex5,
					  in_port0,in_port1,mem_dataout,io_read_data);
	

endmodule



