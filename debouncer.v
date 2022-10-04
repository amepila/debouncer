/*----------------------------------------------------------------------------------------
** MODULE NAME: debouncer.v
** DESCRIPTION: Instance module of debouncer
** INPUTS: 		clk, nrst, sw  
** OUTPUTS:  	one_shot
** VERSION:  	1.0
** AUTHORS:  	Based on the code of Prof. Cuauthemoc Aguilera
** DATE:    	05 / 10 / 22
** -------------------------------------------------------------------------------------- */
module debouncer
(
	input clk,
	input nrst,			
	input sw,			// Input swtich from board
	output one_shot		// Output generated pulse
);

wire w_end_delay, w_rst_out, w_rst;

assign w_rst = ~nrst;	// Assign to active-low reset

control_debouncer	fsm (.clk(clk), .rst(w_rst), .sw(sw), .end_delay(w_end_delay),
						.rst_out(w_rst_out), .one_shot(one_shot));
						
delayer #(.YY(10))	// Parameter to define the time to delay, 1,500,000 counts to reach 30ms
	delay_30ms (.clk(clk), .rst(w_rst_out), .en(1'b1), .equal(w_end_delay));
	
endmodule