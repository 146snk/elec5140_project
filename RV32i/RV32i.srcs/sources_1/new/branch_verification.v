`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2024 21:20:13
// Design Name: 
// Module Name: branch_verification
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


module branch_verification(
    input zero,
    input prediction,
    input [1:0] branch,
    input [2:0] Fun1,
    output reg taken,
    output reg misprediction
    
    );
    always @(*)begin
        if(branch == 2'b01)begin
            case (Fun1)
                3'b000:

 taken = zero;   // BEQ
 
                3'b001: taken = ~zero;  // BNE

                3'b100: taken = zero;   // BLT


                3'b101: taken = zero;   // BGE


                3'b110: taken = zero;   // BLTU

                3'b111: taken = zero; // BGEU


            endcase
            misprediction = prediction ^ taken;
        end
        else begin
            taken = 1'b0;
            misprediction = 1'b0;
        end
    end
endmodule
