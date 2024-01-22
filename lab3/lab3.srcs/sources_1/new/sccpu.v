`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
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
module controlUnit (z, op, funct, pcsrc, aluc, shift, wreg, wmem, regrt, jal, m2reg, aluimm, sext); //the control unit for aclu
    input z; 
    input [5:0] op;
    input [5:0] funct;
    output reg[1:0] pcsrc;
    output reg[3:0] aluc;
    output reg shift;
    output reg wreg;
    output reg wmem;
    output reg regrt;
    output reg jal; 
    output reg m2reg;
    output reg aluimm;
    output reg sext;
    always @*
    begin
        if(op == 0)
        begin
            pcsrc <= 0;
            regrt <= 0;
            jal <= 0;
            m2reg <= 0;
            aluimm <= 0;
            sext <= 1'b0;
            wmem <= 0;
            if (funct == 6'b100000)//add
                begin
                wreg <= 1;
                aluc <= 4'b0000;
                shift <= 0;
                pcsrc <= 0;
                end
            else if (funct == 6'b100010)//sub
                begin
                wreg <= 1;
                aluc <= 4'b0100;
                shift <= 0;
                end
            else if (funct == 6'b100100)//and
                begin
                wreg <= 1;
                aluc <= 4'b0001;
                shift <= 0;
                end
            else if (funct == 6'b100101)//or
                begin
                wreg <= 1;
                aluc <= 4'b0101;
                shift <= 0;
                end
            else if (funct == 6'b100110)//xor
                begin
                wreg <= 1;
                aluc <= 4'b0010;
                shift <= 0;
                end
            else if (funct == 6'b000000)//SLL
                begin
                wreg <= 1;
                aluc <= 4'b0011;
                shift <= 1;
                end
            else if (funct == 6'b000010)//SRL
                begin
                pcsrc <= 0;
                wreg <= 1;
                aluc <= 4'b0111;
                shift <= 1;
                end
            else if (funct == 6'b000011)//SRA
                begin
                wreg <= 1;
                aluc <= 4'b1111;
                shift <= 1;
                end
            else if (funct == 6'b001000) //jr
                begin
                wreg <=0;
                aluc <= 4'b0000;
                pcsrc <= 2'b10;    
                end
        end
        else if (op == 6'b001000) //addi
        begin
            wreg <= 1;
            regrt <= 1;
            jal <= 0;
            m2reg <= 0;
            shift <= 0;
            aluimm <= 1;
            sext <= 1;
            aluc <= 4'b0000;
            wmem <= 0;
            pcsrc <= 00;
        end 
        else if (op == 6'b001100) //andi
        begin
            wreg <= 1;
            regrt <= 1;
            jal <= 0;
            m2reg <= 0;
            shift <= 0;
            aluimm <= 1;
            sext <= 0;
            aluc <= 4'b0001;
            wmem <= 0;
            pcsrc <= 00;
        end
        else if (op == 6'b001101) //ori
        begin
            wreg <= 1;
            regrt <= 1;
            jal <= 0;
            m2reg <= 0;
            shift <= 0;
            aluimm <= 1;
            sext <= 0;
            aluc <= 4'b0101;
            wmem <= 0;
            pcsrc <= 00;
        end
        else if (op == 6'b001110) //xori
        begin
            wreg <= 1;
            regrt <= 1;
            jal <= 0;
            m2reg <= 0;
            shift <= 0;
            aluimm <= 1;
            sext <= 0;
            aluc <= 4'b0010;
            wmem <= 0;
            pcsrc <= 00;
        end
        else if (op == 6'b100011) //lw
        begin
            wreg <= 1;
            regrt <= 1;
            jal <= 0;
            m2reg <= 1;
            shift <= 0;
            aluimm <= 1;
            sext <= 1;
            aluc <= 4'b0000;
            wmem <= 0;
            pcsrc <= 00;
        end
        else if (op == 6'b101011) //sw
        begin
            wreg <= 0;
            regrt <= 1'b0;
            jal <= 1'b0;
            m2reg <= 1'b0;
            shift <= 0;
            aluimm <= 1;
            sext <= 1;
            aluc <= 4'b0000;
            wmem <= 1;
            pcsrc <= 00;
        end
        else if (op == 6'b000100) //beq
        begin
            if (z == 0)
                begin
                wreg <= 0;
                regrt <= 1'b0;
                jal <= 1'b0;
                m2reg <= 1'b0;
                shift <= 0;
                aluimm <= 0;
                sext <= 1;
                aluc <= 4'b0010;
                wmem <= 0;
                pcsrc <= 00;
                end
            else if (z == 1)
                begin
                wreg <= 0;
                regrt <= 1'b0;
                jal <= 1'b0;
                m2reg <= 1'b0;
                shift <= 0;
                aluimm <= 0;
                sext <= 1;
                aluc <= 4'b0010;
                wmem <= 0;
                pcsrc <= 2'b01;
                end
        end
        else if (op == 6'b000101) //bne
        begin
            if (z == 0)
            begin
                wreg <= 0;
                regrt <= 1'b0;
                jal <= 1'b0;
                m2reg <= 1'b0;
                shift <= 0;
                aluimm <= 0;
                sext <= 1;
                aluc <= 4'b0010;
                wmem <= 0;
                pcsrc <= 2'b01;//change back
            end
            else if (z == 1)
            begin
                wreg <= 0;
                regrt <= 1'b0;
                jal <= 1'b0;
                m2reg <= 1'b0;
                shift <= 0;
                aluimm <= 0;
                sext <= 1;
                aluc <= 4'b0010;
                wmem <= 0;
                pcsrc <= 2'b00;
            end
        end 
        else if (op == 6'b001111) //lui
        begin
            wreg <= 1;
            regrt <= 1;
            jal <= 0;
            m2reg <= 0;
            shift <= 1'b0;
            aluimm <= 1;
            sext <= 1'b0;
            aluc <= 4'b0110;
            wmem <= 0;
            pcsrc <= 00;
        end
        else if (op == 6'b000010) //j
        begin
            wreg <= 0;
            regrt <= 1'b0;
            jal <= 1'b0;
            m2reg <= 1'b0;
            shift <= 1'b0;
            aluimm <= 1'b0;
            sext <= 1'b0;
            aluc <= 4'b0000;
            wmem <= 0;
            pcsrc <= 2'b11;
        end
        else if (op == 6'b000011) //jal
        begin
            wreg <= 1;
            regrt <= 1'b0;
            jal <= 1;
            m2reg <= 1'b0;
            shift <= 1'b0;
            aluimm <= 1'b0;
            sext <= 1'b0;
            aluc <= 4'b0000;
            wmem <= 0;
            pcsrc <= 2'b11;
        end  
    end 
endmodule


module regfile (rna,rnb,d,wn,we,clk,clrn,qa,qb); // 32x32 regfile
    input [31:0] d; // data of write port
    input [4:0] rna; // reg # of read port A
    input [4:0] rnb; // reg # of read port B
    input [4:0] wn; // reg # of write port
    input we; // write enable
    input clk, clrn; // clock and reset
    output [31:0] qa, qb; // read ports A and B
    //output reg [31:0] ra;//ra out
    reg [31:0] register [1:31]; // 31 32-bit registers
    assign qa = (rna == 0)? 0 : register[rna]; // read port A
    assign qb = (rnb == 0)? 0 : register[rnb]; // read port B
    integer i;
    always @(posedge clk, negedge clrn) // write port
        begin
        //ra <= register[31];
        if (!clrn)
            for (i = 1; i < 32; i = i + 1)
                register[i] <= 0; // reset
        else
            if ((wn != 0) && we) // not reg[0] & enabled
                register[wn] <= d; // write d to reg[wn]
        end
    initial
    begin //set initial registers
    for (i = 1; i < 32; i = i + 1)
                register[i] <= 0; // reset
    /*
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
        register[31] = 32'h0;
       */
    end
endmodule

module alu (a, b, aluc, z, r); //"processor"
    input [31:0] a;
    input [31:0] b;
    input [3:0] aluc;
    output z;
    output reg [31:0] r;
    assign z =(r==0);
    always @*
    begin
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
        else if (aluc [2:0] == 3'b110)//lui
            r <= b[15:0];
        else if (aluc == 4'b0011)//SLL
            r <= b<<a;
        else if (aluc == 4'b0111)//SRL
            r <= b>>a;
        else if (aluc == 4'b1111)//SRA
            r <= b>>>a;
     end
endmodule

//Mux Chips
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

module TwoOneMux (TwoOneIn,AIn, BIn, TwoOneOut); //two to one mux chip
    input TwoOneIn;
    input [31:0] AIn;
    input [31:0] BIn;
    output reg [31:0] TwoOneOut;
    always @*
        begin
        if (TwoOneIn == 0)
            TwoOneOut <= AIn;
        else if (TwoOneIn == 1)
            TwoOneOut <= BIn;
        end
endmodule

//Adder
module Addr(a,b,out);
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] out;
    always @*
        begin
        out <= a+b;
        end
endmodule

//Add 4 to PC
module pcAdd (pcInput, addPC); //add 4 to the program counter address
    input [31:0] pcInput;
    output reg [31:0] addPC;
    always @*
    begin
        addPC <= pcInput+4;
    end
endmodule

module leftShift (shiftIn, shiftOut); //shift left by 2
    input [31:0] shiftIn;
    output reg [31:0] shiftOut;
    always @*
    begin
        shiftOut <= shiftIn << 2;
    end
endmodule

module sextChip (sext, immIn, sextOut);
    input sext;
    input [15:0] immIn;
    output reg [31:0] sextOut;
    always @*
    begin
        if (sext == 0)
            sextOut <= immIn;
        else if (sext == 1)
            begin
            if (immIn[15] == 1)
                begin
                sextOut [31:16] <= 16'b1111111111111111;
                sextOut [15:0] <= immIn;
                end
            else if (immIn[15] == 0)
                begin
                sextOut [31:16] = 0;
                sextOut [15:0] <= immIn;
                end  
        end
    end
endmodule

module pc (clk,clr, pcIn, pcOut); //pc
    input clk;
    input clr;
    input [31:0] pcIn;
    output reg [31:0] pcOut;
    initial
        begin
           pcOut <= 0;
        end
    
    always @(posedge clk)
        if(clr==0)
            pcOut<=0;
        else
        pcOut <= pcIn;
endmodule

module sccpu(
    input [31:0] inst, mem,
    input clrn, clk,
    output [31:0] pc, alu_out, 
    output reg [31:0] data,
    output wmem
    );
    //all wires
    // parts of the instruction
    wire [5:0] op = inst[31:26];
    wire [4:0] rs = inst[25:21];
    wire [4:0] rt = inst[20:16];
    wire [4:0] rd = inst[15:11];
    wire [5:0] func = inst[05:00];
    wire [15:0] imm = inst[15:00];
    wire [25:0] addr = inst[25:00];      
    
    // control
    wire [3:0] aluc;
    wire [1:0] pcsrc;
    wire wreg,regrt,m2reg,shift,aluimm,sext,z,jal; 
    
    // data
    wire [31:0] sa = {27'b0,inst[10:06]};
    wire [31:0] p4;  
    wire [31:0] nextpc; 
    wire [31:0] write_data;
    wire [31:0] qa,qb;
    wire [31:0] alua;
    wire [31:0] imm_32;
    wire [31:0] alub;
    wire [31:0] imm_shift = {imm_32[29:0],2'b00};
    wire [31:0] branchOut;
    wire [31:0] jpc = {p4[31:28],addr,2'b00};
    wire [4:0] wn;
    wire [4:0] jal_datain;
    wire [31:0] mux_Writedata;
    
    //the chips
    pc thePc(clk,clrn,nextpc,pc); // pc
    pcAdd pcAddr(pc,p4); //add 4 to pc
    controlUnit controller(z, op, func, pcsrc, aluc, shift, wreg, wmem, regrt, jal, m2reg, aluimm, sext); // controller
    TwoOneMux ReggiMux(regrt,rd,rt,jal_datain); //reg write mux
    TwoOneMux wnMux(jal,jal_datain,5'b11111,wn); //jal mux wn
    regfile reggi(rs,rt,write_data,wn,wreg,clk,clrn,qa,qb); //register
    TwoOneMux aluaMux(shift,qa,sa,alua); //alu input a
    sextChip sext_Chip(sext,imm,imm_32); //sign extend
    TwoOneMux alubMux(aluimm,qb,imm_32,alub); //alu input b
    alu theProcessor(alua,alub,aluc,z,alu_out); //alu       
    TwoOneMux dataMux(m2reg,alu_out,mem,mux_Writedata); //chose data to send
    TwoOneMux dataReggiMux(jal,mux_Writedata,p4,write_data); //data into reggi
    Addr branchAdd(p4,imm_shift,branchOut); //adder
    pcMux pcMuxs(pcsrc,p4,branchOut,qa,jpc,nextpc); //pc mux
    
    //assign data
    always @*
    begin
    data <= qb;
    end
endmodule