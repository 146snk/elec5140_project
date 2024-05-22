`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2024 23:15:57
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
    input [1:0] counter_in,
    input data_in,
    output reg [1:0] counter_out
    );
    always @(*) begin
		case(counter_in)
			2'b00: 
				if(data_in == 0) counter_out<= 2'b00;
				else counter_out <= 2'b01;
			2'b01: 
				if(data_in == 0) counter_out<= 2'b00;
				else counter_out <= 2'b10;
			2'b10: 
				if(data_in == 0) counter_out<= 2'b01;
				else counter_out <= 2'b11;
			2'b11: 
				if(data_in == 0) counter_out<= 2'b10;
				else counter_out <= 2'b11;
		endcase
	end
endmodule
