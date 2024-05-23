`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2024 21:50:33
// Design Name: 
// Module Name: pattern_history_table
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


module pattern_history_table
# (parameter SIZE = 4) (
    input rst, input clk,
	
	input [SIZE-1:0] read1_addr,
	output read1_data_out,

    input [SIZE-1:0] read2_addr,
    input en,
    output [1:0] read2_data_out,
	input [1:0] update
    );  
    reg [1:0] registers [2**SIZE-1:0];
	integer i;
	
	// assynchronous assignments
	assign read1_data_out = registers[read1_addr][1];
    assign read2_data_out = registers[read2_addr];
	
	// synchronous assignments
    always @(posedge rst or negedge clk) begin
        if (rst == 1) begin
            for (i=0;i<2**SIZE;i=i+1)
				registers[i] = 2'b11;
        end
        else if(en == 1) begin
            registers[read2_addr] <= update;
        end
    end
endmodule
