`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2024 00:52:04
// Design Name: 
// Module Name: branch_history_register
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


module branch_history_register
# (parameter SIZE = 4) (
    input rst, input clk,
    input data_in,
	input en,
    output reg [SIZE-1:0] branch_history_register
    );
	always @(posedge rst or negedge clk) begin
		if (rst == 1) branch_history_register = 0;
		else if (en ==1)begin
			branch_history_register[SIZE-1:1] <= branch_history_register[SIZE-2:0];
			branch_history_register[0] <= data_in;
		end
	end
endmodule
