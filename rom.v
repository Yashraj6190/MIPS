module instr_mem (
    input [31:0] read_address,
    output reg [31:0] instr
    );
    parameter propDelay=2;
    
    
    reg [31:0] mem [0:28];
    
    initial
    begin
        mem[0] = 'b001000_00000_01000_0000_0000_0000_0101; //addi $t0,$zero,5
        mem[4] = 'b001000_00000_01001_0000_0000_0000_0110; //addi $t1,$zero,6
        mem[8] = 'b001010_00000_01001_0000_0000_0000_0001; //slti $t1,$zero,1
        mem[12] = 'b001010_00000_01001_0000_0000_0000_0000; //slti $t1,$zero,0
        mem[16] = 'b001100_01000_01001_0000_0000_0000_1111; //andi $t1,$t0,15
        mem[20] = 'b001101_01000_01001_0000_0000_0000_1000; //ori $t1,$t0,8
        mem[24] = 'b000000_01000_01001_01010_00000_100000;  //add $t2,$t0,$t1
        mem[28] = 'b101011_00000_01010_0000_0000_0000_0100; //sw $t2,4($zero)
    end
    
    always @(*)
    begin
        #propDelay instr = mem[read_address];
    end
    
    
endmodule