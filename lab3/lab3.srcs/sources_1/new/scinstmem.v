`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Robert Bennethum
// 
// Create Date: 03/24/2023 02:54:51 PM
// Design Name: 
// Module Name: scinstmem
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
module instrMem (memAddress, inst); //instructions memory block
    input [31:0] memAddress;
    output reg [31:0] inst;
    reg[7:0] instructions [0:256];
    always @*
    begin
        inst [31:24] <= instructions[memAddress];
        inst [23:16] <= instructions[memAddress+1];
        inst [15:8] <= instructions[memAddress+2];
        inst [7:0] <= instructions[memAddress+3];
    end
        
    initial
        begin
        /*
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
         */
         /*
         
         //main: lui $1, 0
         instructions[0] = 8'h3c;
         instructions[1] = 8'h01;
         instructions[2] = 8'h00;
         instructions[3] = 8'h00;
         
         //ori $4, $1, 80
         instructions[4] = 8'h34;
         instructions[5] = 8'h24;
         instructions[6] = 8'h00;
         instructions[7] = 8'h80;
         
         //addi $5, $0, 4
         instructions[8] = 8'h20;
         instructions[9] = 8'h05;
         instructions[10] = 8'h00;
         instructions[11] = 8'h04;
         
         // (0c) add $8, $0, $0
         instructions[12] = 8'h00;
         instructions[13] = 8'h00;
         instructions[14] = 8'h40;
         instructions[15] = 8'h20;
         
        // (10) sw $2, 0($4)
        instructions[16] = 8'hac;
        instructions[17] = 8'h82;
        instructions[18] = 8'h00;
        instructions[19] = 8'h00;
        
        // (14) lw $9, 0($4)
        instructions[20] = 8'h8c;
        instructions[21] = 8'h89;
        instructions[22] = 8'h00;
        instructions[23] = 8'h00;
        
        // (18) sub $8, $9, $4
        instructions[24] = 8'h01;
        instructions[25] = 8'h24;
        instructions[26] = 8'h40;
        instructions[27] = 8'h22;
        
        // (1c) addi $5, $0, 3
        instructions[28] = 8'h20;
        instructions[29] = 8'h05;
        instructions[30] = 8'h00;
        instructions[31] = 8'h03;
        
        // (20) loop2: addi $5, $5, -1
        instructions[32] = 8'h20;
        instructions[33] = 8'ha5;
        instructions[34] = 8'hff;
        instructions[35] = 8'hff;
        
        // (24) ori $8, $5, 0xffff
        instructions[36] = 8'h34;
        instructions[37] = 8'ha8;
        instructions[38] = 8'hff;
        instructions[39] = 8'hff;
        
        // (28) xori $8, $8, 0x5555
        instructions[40] = 8'h39;
        instructions[41] = 8'h08;
        instructions[42] = 8'h55;
        instructions[43] = 8'h55;
        
        // (2c) addi $9, $0, -1
        instructions[44] = 8'h20;
        instructions[45] = 8'h09;
        instructions[46] = 8'hff;
        instructions[47] = 8'hff;
        
        // (30) andi $10,$9, 0xffff
        instructions[48] = 8'h31;
        instructions[49] = 8'h2a;
        instructions[50] = 8'hff;
        instructions[51] = 8'hff;
        
        // (34) or $6, $10, $9
        instructions[52] = 8'h01;
        instructions[53] = 8'h49;
        instructions[54] = 8'h30;
        instructions[55] = 8'h25;
        
        // (38) xor $8, $10, $9
        instructions[56] = 8'h01;
        instructions[57] = 8'h49;
        instructions[58] = 8'h40;
        instructions[59] = 8'h26;
        
        // (3c) and $7, $10, $6
        instructions[60] = 8'h01;
        instructions[61] = 8'h46;
        instructions[62] = 8'h38;
        instructions[63] = 8'h24;
        
        // (40) beq $5, $0, shift
        instructions[64] = 8'h10;
        instructions[65] = 8'ha0;
        instructions[66] = 8'h00;
        instructions[67] = 8'h01;
        
        // (44) j loop2
        instructions[68] = 8'h08;
        instructions[69] = 8'h00;
        instructions[70] = 8'h00;
        instructions[71] = 8'h20;
        
        // (48) shift: addi $5, $0, -1
        instructions[72] = 8'h20;
        instructions[73] = 8'h05;
        instructions[74] = 8'hff;
        instructions[75] = 8'hff;
        */
        /*
        // (00) jal 2
        instructions[0] = 8'b00001100;
        instructions[1] = 8'b00000000;
        instructions[2] = 8'b00000000;
        instructions[3] = 8'b00000010;
        
        // (04) bne $5, $0, L1
        instructions[4] = 8'b00010100;
        instructions[5] = 8'b10100000;
        instructions[6] = 8'b00000000;
        instructions[7] = 8'b00000001;
        // (08) L1: jr $rs (assume rs has the address of 8 "$t0")
        //jr $t0
        instructions[8] = 8'b00000001;
        instructions[9] = 8'b00000000;
        instructions[10] = 8'b00000000;
        instructions[11] = 8'b00001000;
        
        //sw $ra to show $ra
        instructions[8] = 8'b00000001;
        instructions[9] = 8'b00000000;
        instructions[10] = 8'b00000000;
        instructions[11] = 8'b00001000;
        */
        
        // instruction // (pc) label instruction
        instructions [0] = 8'h3c; // (00) main: lui $1, 0
        instructions [1] = 8'h01;
        instructions [2] = 8'h00;
        instructions [3] = 8'h00;
        instructions [4] = 8'h34; // (04) ori $4, $1, 80
        instructions [5] = 8'h24;
        instructions [6] = 8'h00;
        instructions [7] = 8'h50;
        instructions [8] = 8'h20; // (08) addi $5, $0, 4
        instructions [9] = 8'h05;
        instructions [10] = 8'h00;
        instructions [11] = 8'h04;
        instructions [12] = 8'h0c; // (0c) call: jal sum
        instructions [13] = 8'h00;
        instructions [14] = 8'h00;
        instructions [15] = 8'h18;
        instructions [16] = 8'hac; // (10) sw $2, 0($4)
        instructions [17] = 8'h82;
        instructions [18] = 8'h00;
        instructions [19] = 8'h00;
        instructions [20] = 8'h8c; // (14) lw $9, 0($4)
        instructions [21] = 8'h89;
        instructions [22] = 8'h00;
        instructions [23] = 8'h00;
        instructions [24] = 8'h01; // (18) sub $8, $9, $4
        instructions [25] = 8'h24;
        instructions [26] = 8'h40;
        instructions [27] = 8'h22;
        instructions [28] = 8'h20; // (1c) addi $5, $0, 3
        instructions [29] = 8'h05;
        instructions [30] = 8'h00;
        instructions [31] = 8'h03;
        instructions [32] = 8'h20; // (20) loop2: addi $5, $5, -1
        instructions [33] = 8'ha5;
        instructions [34] = 8'hff;
        instructions [35] = 8'hff;
        instructions [36] = 8'h34; // (24) ori $8, $5, 0xffff
        instructions [37] = 8'ha8;
        instructions [38] = 8'hff;
        instructions [39] = 8'hff;
        instructions [40] = 8'h39; // (28) xori $8, $8, 0x5555
        instructions [41] = 8'h08;
        instructions [42] = 8'h55;
        instructions [43] = 8'h55;
        instructions [44] = 8'h20; // (2c) addi $9, $0, -1
        instructions [45] = 8'h09;
        instructions [46] = 8'hff;
        instructions [47] = 8'hff;
        instructions [48] = 8'h31; // (30) andi $10,$9, 0xffff
        instructions [49] = 8'h2a;
        instructions [50] = 8'hff;
        instructions [51] = 8'hff;
        instructions [52] = 8'h01; // (34) or $6, $10, $9
        instructions [53] = 8'h49;
        instructions [54] = 8'h30;
        instructions [55] = 8'h25;
        instructions [56] = 8'h01; // (38) xor $8, $10, $9
        instructions [57] = 8'h49;
        instructions [58] = 8'h40;
        instructions [59] = 8'h26;
        instructions [60] = 8'h01; // (3c) and $7, $10, $6
        instructions [61] = 8'h46;
        instructions [62] = 8'h38;
        instructions [63] = 8'h24;
        instructions [64] = 8'h10; // (40) beq $5, $0, shift
        instructions [65] = 8'ha0;
        instructions [66] = 8'h00;
        instructions [67] = 8'h01;
        instructions [68] = 8'h08; // (44) j loop2
        instructions [69] = 8'h00;
        instructions [70] = 8'h00;
        instructions [71] = 8'h08;
        instructions [72] = 8'h20; // (48) shift: addi $5, $0, -1
        instructions [73] = 8'h05;
        instructions [74] = 8'hff;
        instructions [75] = 8'hff;
        instructions [76] = 8'h00; // (4c) sll $8, $5, 15
        instructions [77] = 8'h05;
        instructions [78] = 8'h43;
        instructions [79] = 8'hc0;
        instructions [80] = 8'h00; // (50) sll $8, $8, 16
        instructions [81] = 8'h08;
        instructions [82] = 8'h44;
        instructions [83] = 8'h00;
        instructions [84] = 8'h00; // (54) sra $8, $8, 16
        instructions [85] = 8'h08;
        instructions [86] = 8'h44;
        instructions [87] = 8'h03;
        instructions [88] = 8'h00; // (58) srl $8, $8, 15
        instructions [89] = 8'h08;
        instructions [90] = 8'h43;
        instructions [91] = 8'hc2;
        instructions [92] = 8'h08; // (5c) finish: j finish
        instructions [93] = 8'h00;
        instructions [94] = 8'h00;
        instructions [95] = 8'h17;
        instructions [96] = 8'h00; // (60) sum: add $8, $0, $0
        instructions [97] = 8'h00;
        instructions [98] = 8'h40;
        instructions [99] = 8'h20;
        instructions [100] = 8'h8c; // (64) loop: lw $9, 0($4)
        instructions [101] = 8'h89;
        instructions [102] = 8'h00;
        instructions [103] = 8'h00;
        instructions [104] = 8'h20; // (68) addi $4, $4, 4
        instructions [105] = 8'h84;
        instructions [106] = 8'h00;
        instructions [107] = 8'h04;
        instructions [108] = 8'h01; // (6c) add $8, $8, $9
        instructions [109] = 8'h09;
        instructions [110] = 8'h40;
        instructions [111] = 8'h20;
        instructions [112] = 8'h20; // (70) addi $5, $5, -1
        instructions [113] = 8'ha5;
        instructions [114] = 8'hff;
        instructions [115] = 8'hff;
        instructions [116] = 8'h14; // (74) bne $5, $0, loop
        instructions [117] = 8'ha0;
        instructions [118] = 8'hff;
        instructions [119] = 8'hfb;
        instructions [120] = 8'h00; // (78) sll $2, $8, 0
        instructions [121] = 8'h08;
        instructions [122] = 8'h10;
        instructions [123] = 8'h00;
        instructions [124] = 8'h03; // (7c) jr $31
        instructions [125] = 8'he0;
        instructions [126] = 8'h00;
        instructions [127] = 8'h08;
        end
        /*
        // instruction // (pc) label instruction
32'h3c010000; // (00) main: lui $1, 0
32'h34240050; // (04) ori $4, $1, 80
32'h20050004; // (08) addi $5, $0, 4
32'h0c000018; // (0c) call: jal sum
32'hac820000; // (10) sw $2, 0($4)
32'h8c890000; // (14) lw $9, 0($4)
32'h01244022; // (18) sub $8, $9, $4
32'h20050003; // (1c) addi $5, $0, 3
32'h20a5ffff; // (20) loop2: addi $5, $5, -1
32'h34a8ffff; // (24) ori $8, $5, 0xffff
32'h39085555; // (28) xori $8, $8, 0x5555
32'h2009ffff; // (2c) addi $9, $0, -1
32'h312affff; // (30) andi $10,$9, 0xffff
32'h01493025; // (34) or $6, $10, $9
32'h01494026; // (38) xor $8, $10, $9
32'h01463824; // (3c) and $7, $10, $6
32'h10a00001; // (40) beq $5, $0, shift
32'h08000008; // (44) j loop2
32'h2005ffff; // (48) shift: addi $5, $0, -1
32'h000543c0; // (4c) sll $8, $5, 15
32'h00084400; // (50) sll $8, $8, 16
32'h00084403; // (54) sra $8, $8, 16
32'h000843c2; // (58) srl $8, $8, 15
32'h08000017; // (5c) finish: j finish
32'h00004020; // (60) sum: add $8, $0, $0
32'h8c890000; // (64) loop: lw $9, 0($4)
32'h20840004; // (68) addi $4, $4, 4
32'h01094020; // (6c) add $8, $8, $9
32'h20a5ffff; // (70) addi $5, $5, -1
32'h14a0fffb; // (74) bne $5, $0, loop
32'h00081000; // (78) sll $2, $8, 0
32'h03e00008; // (7c) jr $31
*/
        
endmodule

module scinstmem(
    input [31:0] a,
    output reg [31:0] inst
    );
    wire [31:0] inst1;
    instrMem instructions(a, inst1);
    always @*
        inst <= inst1;
endmodule
