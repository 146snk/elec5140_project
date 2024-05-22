`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2024 23:34:38
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


module branch_predictor
# (parameter SIZE = 4) (
	input rst, input clk,
    input [31:0] IF_ID_PC,
    output prediction,
    input [31:0] ID_EXE_PC,
    input [1:0] ID_EXE_branch,
    input taken
    );
	wire [1:0] read_counter;
	wire [1:0] write_counter;
	
	pattern_history_table _PHT_(
		.read1_addr(IF_ID_PC[SIZE-1:0]),
		.read1_data_out(prediction),
        .read2_addr(ID_EXE_PC[SIZE-1:0]),
        .ID_EXE_branch(ID_EXE_branch),
        .rst(rst),
        .clk(clk),
        .read2_data_out(read_counter),
		.update(write_counter)
	);
	
	saturating_counter_2bit _sat_count_(
		.counter_in(read_counter),
		.data_in(taken),
		.counter_out(write_counter)
	);
endmodule
