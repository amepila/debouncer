module blink_reg
#(parameter DW = 1)
(
	input clk, rst, en,
	output reg [DW-1:0]led
);

always@(posedge clk, negedge rst)
	begin
		if(~rst)
			led <= 1'b1;
		else if(en)
			led <= ~led;
		else
			led <= led;
	end
endmodule
	
