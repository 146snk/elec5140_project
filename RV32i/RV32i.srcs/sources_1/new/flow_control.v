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
    output reg c_stall
    );
    always @(*)begin
        if(misprediction == 1'b1)begin
            next_PC = ID_EXE_mispredict_PC;
            c_stall = 1'b1;
        end
        else case(branch)
            2'b00:begin
                next_PC = add_PC4;
                c_stall = 1'b0;
            end
            2'b01:begin
                if(prediction == 0)begin
                    next_PC = add_PC4;
                    mispredict_PC = add_branch;
                    c_stall = 1'b0;
                end
                else begin
                    next_PC = add_branch;
                    mispredict_PC = PC_out;
                    c_stall = 1'b1;
                end
            end
            2'b10:begin
                next_PC = add_jal;
                c_stall = 1'b1;
            end
            2'b11:begin
                next_PC = add_jalr;
                c_stall = 1'b1;
            end   
        endcase
    end
endmodule
