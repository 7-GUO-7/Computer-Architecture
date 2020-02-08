module pipeexe(ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,ejal,ern,ealu);
input wire[3:0] ealuc;
input wire[31:0] ea, eb, eimm;
input wire ealuimm, eshift;
input wire ejal;
input wire[4:0] ern0;
output wire[4:0] ern;
output wire[31:0] ealu, epc4;

wire [31:0] alua,alub,aluout;
mux2x32 alu_b(eb,eimm,ealuimm,alub);
alu agorithm_logic_unit(ea,alub,ealuc,aluout);
mux2x32 call_sub(aluout,epc4,ejal,ealu);
assign ern = ern0 | {5{ejal}}; // jal: r31 <-- p4;  // 31 or ern0/ reg_dest - mc

endmodule