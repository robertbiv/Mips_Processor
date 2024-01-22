`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Robert Bennethum
// 
// Create Date: 03/24/2023 02:54:51 PM
// Design Name: 
// Module Name: scdatamem
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

module DataMem(we, a, di, clk, do);
    input we;
    input [31:0] a;
    input [31:0] di;
    input clk;
    output reg [31:0] do;
    reg [31:0] memory [0:31];
    reg [31:0] b;
    always @*
    begin
        do = memory[a[6:2]];
    end
    always @(posedge clk)
        begin
            if (we)
                memory[a[6:2]] = di; //like right shift 2
        end
    integer i;
    initial begin  
        for (i = 0; i < 32; i = i + 1)
            memory[i] = 0;
            // ram[word_addr] = data // (byte_addr)
            memory[5'h14] = 32'h000000a3; // (50hex)
            memory[5'h15] = 32'h00000027; // (54hex)
            memory[5'h16] = 32'h00000079; // (58hex)
            memory[5'h17] = 32'h00000115; // (5chex)
            memory[5'h18] = 32'h00000258;       // the sum stored by sw instruction
            end 
    
endmodule 

module scdatamem(
    input [31:0] addr, datain,
    input we, clk,
    output reg [31:0] dataout
    );
    wire [31:0] doData;
    DataMem daMem(we, addr, datain, clk, doData);
    always @*
    dataout <= doData;
endmodule