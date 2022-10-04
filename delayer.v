/*----------------------------------------------------------------------------------------
** MODULE NAME: delayer.v
** DESCRIPTION: Customized counter
** INPUTS: 		clk, rst, en
** OUTPUTS:  	equal
** VERSION:  	1.0
** AUTHORS:  	Based on the code of Prof. Cuauthemoc Aguilera
** DATE:    	05 / 10 / 22
** -------------------------------------------------------------------------------------- */
module delayer
#(parameter YY = 10)	// It is required 27-bits to represent 100,000,000 counts
(
	input clk, 
	input rst,
	input en,
	output equal
);

localparam WIDTH = $clog2(YY);
reg [WIDTH-1:0] counter;

// Comparator with the couner
assign equal = (YY + 1 == (counter)) ? 1'b1 : 1'b0;

// Counter
always@(posedge clk, posedge rst)
	begin
		if(rst)
			counter <= {WIDTH{1'b0}};
		else
			if(en)
				if(equal)
					counter <= {WIDTH{1'b0}};
				else 
					counter <=  counter + 1'b1;
			else
				counter <= counter;
	end

endmodule