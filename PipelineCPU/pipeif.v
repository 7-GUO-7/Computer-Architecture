module pipeif(pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock);
input wire[1:0] pcsource;
input wire[31:0] pc,bpc,da,jpc;
output wire[31:0] npc,pc4,ins;
input wire mem_clock;

wire[31:0] fetched_ins, nop;
assign nop = 0;
rom irom(pc[7:2],mem_clock,fetched_ins);
assign ins = pcsource[0]?32'h0:fetched_ins;
assign pc4 = pc+32'h4;
mux4x32 new_pc(pc4,bpc,da,jpc,pcsource,npc); //pc+4,branch,da:jr(forwarding),j.
//da will not have data hazards, it will be propagated back directly from ID or EX.

endmodule