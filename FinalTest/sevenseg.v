module sevenseg (data, ledsegments);
    input [31:0] data;
    output ledsegments;
    reg [6:0] ledsegments;
    always @ (*)
		case(data)
			0: ledsegments = 7'b100_0000;
			1: ledsegments = 7'b111_1001;
			2: ledsegments = 7'b010_0100;
			3: ledsegments = 7'b011_0000;
			4: ledsegments = 7'b001_1001;
			5: ledsegments = 7'b001_0010;
			6: ledsegments = 7'b000_0010;
			7: ledsegments = 7'b111_1000;
			8: ledsegments = 7'b000_0000;
			9: ledsegments = 7'b001_0000;
			//10: ledsegments = 7'b011_1111;
			'ha: ledsegments = 7'b000_1000;
			'hb: ledsegments = 7'b000_0011;
			'hc: ledsegments = 7'b100_0110;
			'hd: ledsegments = 7'b010_0001;
			'he: ledsegments = 7'b000_0100;
			'hf: ledsegments = 7'b000_1110;
			default: ledsegments = 7'b111_1111;
		endcase
endmodule
