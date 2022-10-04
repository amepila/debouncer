/*----------------------------------------------------------------------------------------
** MODULE NAME: control_debouncer.v
** DESCRIPTION: FSM of debouncer
** INPUTS: 		clk, rst, sw, end_delay
** OUTPUTS:  	rst_out, one_shot
** VERSION:  	1.0
** AUTHORS:  	Based on the code of Prof. Cuauthemoc Aguilera
** DATE:    	05 / 10 / 22
** -------------------------------------------------------------------------------------- */
module control_debouncer
(
	input clk,
	input rst,
	input sw,
	input end_delay,
	output reg rst_out,
	output reg one_shot
);

// Definition of state codes
parameter [2:0] init = 'b000;
parameter [2:0] shot = 'b001;
parameter [2:0] off1 = 'b011;
parameter [2:0] sw_1 = 'b010;
parameter [2:0] off2 = 'b110;

reg [2:0] state;

always@(posedge clk, posedge rst)
	begin
		if(rst)
			state <= init;
		else
			case(state)	//FSM with state codes
				init:	state <= sw ? shot : init;
				shot:	state <= off1;
				off1: 	state <= end_delay ? sw_1 : off1;
				sw_1:	state <= (~sw) ? off2 : sw_1;
				off2:	state <= end_delay ? init : off2;
				default:	state <= init;
			endcase
	end

always@(state)
	begin
		case(state)		// Outputs according to current state
				init: 	begin one_shot = 'b0; rst_out = 1'b1; end
				shot: 	begin one_shot = 'b1; rst_out = 1'b1; end
				off1: 	begin one_shot = 'b0; rst_out = 1'b0; end
				sw_1: 	begin one_shot = 'b0; rst_out = 1'b1; end
				off2: 	begin one_shot = 'b0; rst_out = 1'b0; end
			 default: 	begin one_shot = 'b0; rst_out = 1'b1; end
		endcase
	end
endmodule