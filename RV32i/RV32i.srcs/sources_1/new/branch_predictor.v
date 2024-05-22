`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2024 16:45:23
// Design Name: 
// Module Name: branch_predictor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module branch_predictor(
    input clk, input rst,
    input [31:0] IF_ID_PC,
    output prediction,
    input [31:0] ID_EXE_PC,
    input taken,
    input [1:0] ID_EXE_branch
    );
	wire [1:0] counter;
	reg counter_en;
	assign prediction = counter[1];
	always @(*) begin
		if(ID_EXE_branch == 2'b01) counter_en = 1; 
		else counter_en = 0;
	end
    saturating_counter_2bit _counter_ (.rst(rst), .clk(clk), .en(counter_en), .data_in(taken), .counter(counter));
endmodule
