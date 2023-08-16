`timescale 1ns / 1ns
`include "cu.v"
`include "pc.v"
`include "adder.v"
`include "mux.v"
`include "reg_file.v"
`include "sign_extend.v"
`include "alu.v"
`include "shift_left.v"

module mips ( input clk, reset,
              input wire [31:0] current_instr, //output of Instruction memory, the intruction to be executed
              input wire [31:0] data_mem_out,  //output of data memory, instruction to be written in register file
              output wire [31:0] instr_address, //from Program COunter to instruction memory
              output wire [31:0] data_mem_read_address, //from alu to data memory
              output wire [31:0] data_mem_write_address, //from alu  to data memory
              output wire [31:0] data_mem_write_data, //from alu to data memory
              output wire mem_write //from cu unit to data memory
              ); 
              
assign data_mem_read_address = alu_result; //alu to data memory
assign data_mem_write_address = alu_result;  //alu to data memory
assign data_mem_write_data = reg_data_2;  //register file read_data_2 to data memory

wire [31:0] next_instr_address; //from program counter adder
wire [31:0] reg_data_1; //from register file to alu
wire [31:0] reg_data_2; //from reigster file to input of mux that gies to alu as b_in
wire [31:0] alu_result; // outout of alu to data memory or mux that goes to register file write_data input
wire [31:0] alu_src_mux_out; //from the alu_src mux to alu input as b_in
wire [31:0] sign_extend_out; //from sign_extend to alu_src mux input or shift left branch adder input
wire [31:0] shift_address_out; //from shift_left to adder of branch 
wire [31:0] jump_address; //output of branch adder to pc_src mux
wire [31:0] pc_mux_out; //pc_src mux to program counter
wire [31:0] reg_write_data; //mem_to_reg mux to write register data
wire [4:0] write_mux_out; //reg_file to reg_dest mux
wire reg_dest; //from cu to reg_dest mux
wire reg_write; //from cu to reg_file
wire mem_to_reg; //from cu to mem_to_reg mux
wire alu_src; //from cu to alu_src mux
wire pc_src; //from cu to pc_src mux
wire zero_flag; //from alu to cu input as zero_in
wire [2:0] alu_op; //from cu to alu

cu cu(
    .op_code(current_instr[31:26]),
    .op_funct(current_instr[5:0]),
    .zero_in(zero_flag),
    .reg_dst(reg_dest),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .alu_op(alu_op),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .pc_src(pc_src)
);


pc pc(
    .clk(clk),
    .reset(reset),
    .pc_in(pc_mux_out),
    .instr_address(instr_address)
);

adder pc_adder(
           .a_in(instr_address),
           .b_in('d4),
           .adder_out(next_instr_address)
   );


 mux #(.width(32)) pc_src_mux(
         .in0(next_instr_address),
         .in1(jump_address),
         .control(pc_src),
         .muxout(pc_mux_out)
 ); 
 
 mux #(.width(5)) reg_dest_mux(
     .in0(current_instr[20:16]),
     .in1(current_instr[15:11]),
     .control(reg_dest),
     .muxout(write_mux_out)
     );
 
 reg_file reg_file(
     .clk(clk),
     .read_address_1(current_instr[25:21]),
     .read_address_2(current_instr[20:16]),
     .write_address(write_mux_out),
     .write_data(reg_write_data),
     .reg_write_en(reg_write),
     .read_data_1(reg_data_1),
     .read_data_2(reg_data_2)
     ); 
     
     
 sign_extend sign_extend(
         .in(current_instr[15:0]),
         .out(sign_extend_out)
         );    
     
 mux #(.width(32)) alu_src_mux(
         .in0(reg_data_2),
         .in1(sign_extend_out),
         .control(alu_src),
         .muxout(alu_src_mux_out)
         );    
     
     
 alu alu(
         .a_in(reg_data_1),
         .b_in(alu_src_mux_out),
         .alu_result(alu_result),
         .alu_op(alu_op),
         .zero_flag(zero_flag)
   ); 
   
   
   mux #(.width(32)) mem_to_reg_mux(
           .in0(alu_result),
           .in1(data_mem_out),
           .control(mem_to_reg),
           .muxout(reg_write_data)
   );  
    
   shift_left sl(
       .in(sign_extend_out),
       .out(shift_address_out)
       );
       
   adder branch_address_adder(
           .a_in(shift_address_out),
           .b_in(next_instr_address),
           .adder_out(jump_address)
   );
  
endmodule