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

module regfile_tb;
    reg [4:0] rna,rnb,wn;
    reg [31:0] d;
    reg we,clk,clrn;
    wire [31:0] qa,qb;
    regfile rf (rna,rnb,d,wn,we,clk,clrn,qa,qb);
    initial begin
        clk = 0;
        clrn = 0;
        #2 clrn = 1;
        we = 1;
        d = 32'hffff0000;
        wn = 0;
        rna = 0;
        rnb = 5'd31;
        #4 we = 0;
        #2 we = 1;
    end
    always #1 clk = !clk;
    always #2 d = d + 1;
    always #2 wn = wn + 1;
    always #2 rna = rna + 1;
    always #2 rnb = rnb + 1;
endmodule

module testbench();
    reg clk;
    wire [31:0] inst_tb, pcOut_tb, qa_tb, qb_tb, r_tb;
    MIPSmachine cpu(clk, inst_tb, pcOut_tb, qa_tb, qb_tb, r_tb);
    /* For Testing
    wire [31:0] regr,regpcOut,regpcAdd,reginst,regPCMuxOut,regqb,regshiftMuxOut,regqa;
    wire [1:0] regPCSRC;
    wire [3:0] regaluc;
    wire regwreg,regshift;
    MIPSmachine cpu(clk, regr, regpcOut, regpcAdd, reginst,regPCMuxOut,regPCSRC,regaluc,regwreg,regqb,regshiftMuxOut,regshift,regqa);
    */
    initial begin
    clk = 0;
    end
    
    always #1 clk = !clk;
endmodule
