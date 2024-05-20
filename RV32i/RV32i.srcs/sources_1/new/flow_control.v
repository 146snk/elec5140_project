`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2024 17:07:24
// Design Name: 
// Module Name: flow_control
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


module flow_control(
    // input
    input [31:0] PC_out,
    input [31:0] add_PC4,
    input [31:0] add_branch,
    input [31:0] add_jal,
    input [31:0] add_jalr,
    input [31:0] ID_EXE_mispredict_PC,
    // ctrl
    input [1:0] branch,
    input misprediction,
    input prediction,
    // output
    output reg[31:0] next_PC,
    output reg [31:0] mispredict_PC,
    output reg IF_ID_cstall,
	output reg ID_EXE_cstall
    );
    always @(*)begin
        if(misprediction == 1'b1)begin
            next_PC = ID_EXE_mispredict_PC;
            IF_ID_cstall = 1'b1;
			ID_EXE_cstall = 1'b1;
        end
        else begin 
			ID_EXE_cstall = 1'b0;
			case(branch)
				2'b00:begin
					next_PC = add_PC4;
					IF_ID_cstall = 1'b0;
				end
				2'b01:begin
					if(prediction == 0)begin
						next_PC = add_PC4;
						mispredict_PC = add_branch;
						IF_ID_cstall = 1'b0;
					end
					else begin
						next_PC = add_branch;
						mispredict_PC = PC_out;
						IF_ID_cstall = 1'b1;
					end
				end
				2'b10:begin
					next_PC = add_jal;
					IF_ID_cstall = 1'b1;
				end
				2'b11:begin
					next_PC = add_jalr;
					IF_ID_cstall = 1'b1;
				end   
			endcase
		end
    end
endmodule
