`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Robert Bennethum IV
// 
// Create Date: 03/03/2023 12:03:24 PM
// Design Name: 
// Module Name: testbench
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
module testbench();
    reg clk;
    reg clrn;
    wire [31:0] pc, inst, alu;
    ConnectionBoard connect4board(clk, clrn, pc, inst, alu);
    
    //clk
    initial begin
    clk = 0;
    clrn = 1;
    end
    
    always #10 clk = !clk;
endmodule
