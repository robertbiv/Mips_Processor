`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2023 07:47:02 PM
// Design Name: 
// Module Name: ConnectionBoard
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


module ConnectionBoard(
    input clk, 
    input clrn,
    output [31:0] pc,
    output [31:0] inst,
    output [31:0] alu
    );
    wire wmem;
    wire [31:0] inst, pc, data, dataout, ra_tb;
    
    //sccpu inputs
    wire [31:0] mem = dataout;
    
    //scdatamem
    wire [31:0] addr = alu;
    wire [31:0] datain = data;
    wire we = wmem;
    
    //scinstmem in
    wire [31:0] a = pc;
    
    //outputs
    wire [31:0] pcMuxOut_tb, qa_tb, p4_tb;
    
    //call the files
    scdatamem DataMem(addr, datain, we, clk, dataout);
    scinstmem InstructionMem(a, inst);
    sccpu CPU(inst, mem, clrn, clk, pc, alu, data, wmem);// pcMuxOut_tb, qa_tb, p4_tb, ra_tb);
endmodule
