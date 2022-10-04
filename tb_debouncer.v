/*----------------------------------------------------------------------------------------
** MODULE NAME: delayer.v
** DESCRIPTION: Customized counter
** INPUTS: 		clk, rst, en
** OUTPUTS:  	equal
** VERSION:  	1.0
** AUTHORS:  	Based on the code of Prof. Cuauthemoc Aguilera
** DATE:    	05 / 10 / 22
** -------------------------------------------------------------------------------------- */
`timescale 1ns / 1ps
module tb_debouncer ();

reg clk, rst, sw;	// Inputs
wire one_shot;		// Outputs

debouncer UUT (.clk(clk), .nrst(rst), .sw(sw), .one_shot(one_shot));

initial 
    begin
        clk = 1'b0;
        rst = 1'b0; 
        sw  = 1'b0;
     #5 rst = 1'b1;
	# 4000 $stop;
    end
always
    begin
      #5  clk = ~clk;
    end

always
    begin
      #10  sw = ~sw;// 1 Bouncing
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// 1
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// 1
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// 1
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// 1
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// 1
      #200 sw = ~sw;// On
      #10  sw = ~sw;// 0 Bouncing
      #10  sw = ~sw;// 1
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// 1
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// 1
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// 1
      #10  sw = ~sw;// 0
      #10  sw = ~sw;// off
      #200;
    end
endmodule
	