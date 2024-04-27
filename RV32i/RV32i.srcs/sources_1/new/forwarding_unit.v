`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2024 23:27:30
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
    input [4:0] ID_EXE_read_reg1,
    input [4:0] ID_EXE_read_reg2,
    input [31:0] ID_EXE_ALU_A,
    input [31:0] ID_EXE_ALU_B, 
    
    input EXE_MEM_RegWrite,
    input [4:0] EXE_MEM_written_reg,
    input [31:0] EXE_MEM_ALU_out,
    
    input MEM_WB_RegWrite,
    input [4:0] MEM_WB_written_reg,
    input [31:0] MEM_WB_reg_Wt_data,
    
    output reg [31:0] ALU_A_out,
    output reg [31:0] ALU_B_out
    );
    always @(*)begin
    // ALU A
        // EXE_MEM -> ID_EXE
        if(EXE_MEM_RegWrite == 1 && ID_EXE_read_reg1 != 0 && ID_EXE_read_reg1 == EXE_MEM_written_reg)
            ALU_A_out = EXE_MEM_ALU_out;
        // MEM_WB -> ID_EXE    
        else if(MEM_WB_RegWrite == 1 && ID_EXE_read_reg1 != 0 && ID_EXE_read_reg1 == MEM_WB_written_reg)
            ALU_A_out = MEM_WB_reg_Wt_data;
        // No forwarding
        else ALU_A_out = ID_EXE_ALU_A;
    // ALU B
        // EXE_MEM -> ID_EXE
        if(EXE_MEM_RegWrite == 1 && ID_EXE_read_reg2 != 0 && ID_EXE_read_reg2 == EXE_MEM_written_reg)
            ALU_B_out = EXE_MEM_ALU_out;
        // MEM_WB -> ID_EXE 
        else if(MEM_WB_RegWrite == 1 && ID_EXE_read_reg2 != 0 && ID_EXE_read_reg2 == MEM_WB_written_reg)
            ALU_B_out = MEM_WB_reg_Wt_data;
        // No forwarding
        else ALU_B_out = ID_EXE_ALU_B;
    end
endmodule
