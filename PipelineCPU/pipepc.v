module pipepc(npc,wpcir,clock,resetn,pc);

input wire[31:0] npc;
input wpcir;
input clock,resetn;
output reg[31:0] pc;

always @(posedge clock)
begin
	if(~resetn)
	begin
		pc <= 0;
	end
	else
	begin
		if(wpcir)
		begin
			pc <= npc;
		end
	end
end

endmodule