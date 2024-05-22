`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2024 11:51:11
// Design Name: 
// Module Name: saturating_counter_2bit
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


module saturating_counter_2bit(
    input rst,
    input clk,
    input en,
    input data_in,
    output reg [1:0] counter
    );
	always @(posedge rst or negedge clk) begin
		if(rst == 1) counter = 2'b00;
		else if(en)begin
			case(counter)
				2'b00:
					if(data_in == 0) counter <= 2'b00;
					else counter <= 2'b01;
				2'b01:
					if(data_in == 0) counter <= 2'b00;
					else counter <= 2'b10;
				2'b10:
					if(data_in == 0) counter <= 2'b01;
					else counter <= 2'b11;
				2'b11:
					if(data_in == 0) counter <= 2'b10;
					else counter <= 2'b11;						
			endcase
		end
	end
endmodule
