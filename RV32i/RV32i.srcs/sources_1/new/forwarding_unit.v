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
    input [31:0] ID_EXE_Data_out,
    input ID_EXE_mem_w,
    
    input EXE_MEM_RegWrite,
    input [4:0] EXE_MEM_written_reg,
    input [31:0] EXE_MEM_ALU_out,
    
    input MEM_WB_RegWrite,
    input [4:0] MEM_WB_written_reg,
    input [31:0] MEM_WB_reg_Wt_data,
    
    output reg [31:0] ALU_A_out,
    output reg [31:0] ALU_B_out,
    output reg [31:0] EXE_Data_out,
    output reg forwarding_flag_A,
    output reg forwarding_flag_B
    
//    ,output reg debug1
    );
    always @(*)begin
    // Default no forwarding    
        ALU_A_out = ID_EXE_ALU_A;
        forwarding_flag_A = 0;
        ALU_B_out = ID_EXE_ALU_B;
        EXE_Data_out = ID_EXE_Data_out;
        forwarding_flag_B = 0;
//        debug1 = 0;
    // ALU A forwarding
        // EXE_MEM -> ID_EXE
        if(EXE_MEM_RegWrite == 1 && ID_EXE_read_reg1 != 0 && ID_EXE_read_reg1 == EXE_MEM_written_reg) begin
            ALU_A_out = EXE_MEM_ALU_out;
            forwarding_flag_A = 1;
//            debug1 = 1;
        end
        // MEM_WB -> ID_EXE    
        else if(MEM_WB_RegWrite == 1 && ID_EXE_read_reg1 != 0 && ID_EXE_read_reg1 == MEM_WB_written_reg) begin
            ALU_A_out = MEM_WB_reg_Wt_data;
            forwarding_flag_A = 1;
        end

    // ALU B forwarding
        // EXE_MEM -> ID_EXE
        if(EXE_MEM_RegWrite == 1 && ID_EXE_read_reg2 != 0 && ID_EXE_read_reg2 == EXE_MEM_written_reg) begin
            if (ID_EXE_mem_w == 0)
                ALU_B_out = EXE_MEM_ALU_out;
            else
                EXE_Data_out = EXE_MEM_ALU_out;
            forwarding_flag_B = 1;
        end
        // MEM_WB -> ID_EXE    
        else if(MEM_WB_RegWrite == 1 && ID_EXE_read_reg2 != 0 && ID_EXE_read_reg2 == MEM_WB_written_reg) begin
            if (ID_EXE_mem_w == 0)
                ALU_B_out = MEM_WB_reg_Wt_data;
            else
                EXE_Data_out = MEM_WB_reg_Wt_data;
            forwarding_flag_B = 1;
        end

    end
endmodule
