`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Robert Bennethum IV
// 
// Create Date: 03/03/2023 12:00:32 PM
// Design Name: 
// Module Name: MIPSmachine
// Project Name: Lab 3
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
module regfile (rna,rnb,d,wn,we,clk,clrn,qa,qb); // 32x32 regfile
    input [31:0] d; // data of write port
    input [4:0] rna; // reg # of read port A
    input [4:0] rnb; // reg # of read port B
    input [4:0] wn; // reg # of write port
    input we; // write enable
    input clk, clrn; // clock and reset
    output [31:0] qa, qb; // read ports A and B
    reg [31:0] register [1:31]; // 31 32-bit registers
    assign qa = (rna == 0)? 0 : register[rna]; // read port A
    assign qb = (rnb == 0)? 0 : register[rnb]; // read port B
    integer i;
    always @(posedge clk or negedge clrn) // write port
        if (!clrn)
            for (i = 1; i < 32; i = i + 1)
                register[i] <= 0; // reset
        else
            if ((wn != 0) && we) // not reg[0] & enabled
                register[wn] <= d; // write d to reg[wn]
        initial
    begin //set initial registers
        register[0] = 32'h00000000;
        register[1] = 32'hA00000AA;
        register[2] = 32'h10000011;
        register[3] = 32'h20000022;
        register[4] = 32'h30000033;
        register[5] = 32'h40000044;
        register[6] = 32'h50000055;
        register[7] = 32'h60000066;
        register[8] = 32'h70000077;
        register[9] = 32'h80000088;
        register[10] = 32'h90000099;
    end
endmodule

module pc (clk, pcIn, pcOut); //Program Counter
    input clk;
    input [31:0] pcIn;
    output reg [31:0] pcOut;
    //Start
    initial
        begin
           pcOut <= 0;
        end
    
    always @(posedge clk)
        pcOut <= pcIn;
endmodule

module pcAdd (pcInput, addPC); //add 4 to the program counter address
    input [31:0] pcInput;
    output reg [31:0] addPC;
    always @*
        addPC <= pcInput+4;
endmodule

module pcMux (pcsrcIn, addPCIn, optn1, optn2, optn3, pcMuxOut); //Program Counter Mux to tell Mux what address is next
    input [1:0] pcsrcIn;
    input [31:0] addPCIn;
    input [31:0] optn1;
    input [31:0] optn2;
    input [31:0] optn3;
    output reg [31:0] pcMuxOut; 
    always @*
        if (pcsrcIn == 0)
            pcMuxOut <= addPCIn;
        else if (pcsrcIn == 1)
            pcMuxOut <= optn1;
        else if (pcsrcIn == 2)
            pcMuxOut <= optn2;
        else if (pcsrcIn == 3)
            pcMuxOut <= optn3;
endmodule

module instrMem (memAddress, inst); //instructions memory block
    input [31:0] memAddress;
    output reg [31:0] inst;
    reg[7:0] instructions [0:31];
    /*wire [7:0] byte1 = instructions[memAddress];
    wire [7:0] byte2 = instructions[memAddress+1];
    wire [7:0] byte3 = instructions[memAddress+2];
    wire [7:0] byte4 = instructions[memAddress+3];
    */
    always @*
    begin
        inst [31:24] <= instructions[memAddress];
        inst [23:16] <= instructions[memAddress+1];
        inst [15:8] <= instructions[memAddress+2];
        inst [7:0] <= instructions[memAddress+3];
    end
        
    initial
        begin
            //load sub $t0, $t1, $a0
            instructions[0] = 8'h01;
            instructions[1] = 8'h24;
            instructions[2] = 8'h40;
            instructions[3] = 8'h22;
            //load or $a2, $t2, $t1
            instructions[4] = 8'h01;
            instructions[5] = 8'h49;
            instructions[6] = 8'h30;
            instructions[7] = 8'h25;
            //load sll $t0, $a1, 15
            instructions[8] = 8'h00;
            instructions[9] = 8'h05;
            instructions[10] = 8'h43;
            instructions[11] = 8'hc0;
        end
endmodule

module controlUnit (op, funct, pcsrc, aluc, shift, wreg); //the control unit for aclu
    input [5:0] op;
    input [4:0] funct;
    output reg[1:0] pcsrc;
    output reg[5:0] aluc;
    output reg shift;
    output reg[1:0] wreg;
    always @*
        if (op == 0)
        begin
            if (funct == 5'b00000)//add
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 3'b100;
                shift <= 0;
                end
            else if (funct == 5'b00010)//sub
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 3'b100;
                shift <= 0;
                end
            else if (funct == 5'b00100)//and
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 3'b001;
                shift <= 0;
                end
            else if (funct == 5'b00101)//or
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 3'b101;
                shift <= 0;
                end
            else if (funct == 5'b00110)//xor
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 3'b010;
                shift <= 0;
                end
            else if (funct == 5'b00000)//SLL
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 4'b0011;
                shift <= 1;
                end
            else if (funct == 5'b00010)//SRL
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 4'b0111;
                shift <= 1;
                end
            else if (funct == 5'b00011)//SRA
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 4'b1111;
                shift <= 1;
                end
        end     
endmodule

module shiftMux (shiftIn,qaIn, saIn, shiftMuxOut); //shift mux
    input shiftIn;
    input [31:0] qaIn;
    input [5:0] saIn;
    output reg [31:0] shiftMuxOut;
    always @*
        if (shiftIn == 0)
            shiftMuxOut <= qaIn;
        else if (shiftIn == 1)
            shiftMuxOut <= saIn;
endmodule

module alu (a, b , aluc, z, r); //"processor"
    input [31:0] a;
    input [31:0] b;
    input [3:0] aluc;
    output reg z;
    output reg [31:0] r;
    always @*
        if (aluc [2:0] == 3'b000)//add
            r <= a+b;
        else if (aluc [2:0] == 3'b100)//sub
            r <= a-b;
        else if (aluc [2:0] == 3'b001)//and
            r <= a&b;
        else if (aluc [2:0] == 3'b101)//or
            r <= a|b;
        else if (aluc [2:0] == 3'b010)//xor
            r <= a^b;
        //else if (aluc [2:0] == 3'b110)//lui
        //    r <= b[15:0];
        else if (aluc == 4'b0011)//SLL
            r <= b<<a;
        else if (aluc == 4'b0111)//SRL
            r <= b>>a;
        else if (aluc == 4'b1111)//SRA
            r <= b>>>a;
endmodule


module MIPSmachine( //to connect and run the circut
    //input from tb
    input clk,
    //outputs to tb
    output reg [31:0] reginst,
    output reg [31:0] regpcOut,
    output reg [31:0] regqa,
    output reg [31:0] regqb,
    output reg [31:0] regr
    
    /*For testing
    output reg [31:0] regpcAdd,
    output reg [31:0] regPCMuxOut,
    output reg [1:0] regPCSRC,
    output reg [3:0] regaluc,
    output reg regwreg,
    output reg [31:0] regshiftMuxOut,
    output reg regshift
    */
    
    

    );
    //Program Counter and Memory Items
    wire [31:0] addPC, pcOut, pcsrc, we, pcMuxOut;
    wire [31:0] pcIn = pcMuxOut;
    wire [31:0] memAddress = pcOut;
    wire [31:0] addPCIn = addPC;
    wire [31:0] pcInput = pcOut;
    wire [31:0] inst;
    wire [1:0] pcsrcIn = pcsrc;
    wire wreg = we;
    
    pcMux pcMuxChip(pcsrcIn, addPCIn, optn1, optn2, optn3, pcMuxOut);
    pc counter(clk, pcIn, pcOut);
    instrMem instructions(memAddress, inst);
    pcAdd pcAdder(pcInput, addPC);
    
    //Instructions and others
    wire [31:0] qa, qb, shiftMuxOut, r;
    wire [5:0] op = inst[31:26];
    wire [5:0] funct = inst[5:0];
    wire [3:0] aluc;
    wire shift;
    wire shiftIn = shift;
    wire [4:0] rna = inst[25:21];
    wire [4:0] rnb = inst[20:16];
    wire [4:0] wn = inst[15:11];
    wire [4:0] saIn = inst[10:6];
    wire [31:0] b = qb;
    wire [31:0] qaIn = qa;
    wire [31:0] a = shiftMuxOut;
    wire [31:0] d = r;
    
    
    controlUnit controled(op, funct, pcsrc, aluc, shift, wreg);
    regfile reggi(rna,rnb,d,wn,we,clk,clrn,qa,qb);
    shiftMux shiftyMux(shiftIn,qaIn, saIn, shiftMuxOut);
    alu theALU(a, b, aluc, z, r);
    
   
    //Always Update to send to tb
    always @*
    begin
        //needed for outputs
        reginst<=inst;
        regpcOut<=pcOut;
        regqa<=qa;
        regqb<=qb;
        regr<=r;
        
        
        /*for testing purposes
        regpcAdd<=addPC;
        regPCMuxOut<=pcMuxOut;
        regPCSRC<=pcsrc;
        regaluc<=aluc;
        regwreg<=wreg;
        regshiftMuxOut<=shiftMuxOut;
        regshift<=shift;
        */
    end
    
endmodule
