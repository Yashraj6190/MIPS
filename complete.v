`timescale 1ns / 1ps
`include "rom.v"
`include "ram.v"
`include "mips.v"

module complete(
input clk, reset );

wire [31:0] instr_address;
wire [31:0] instr;
wire [31:0] data_mem_read_address;
wire [31:0] data_mem_write_address;
wire [31:0] data_mem_write_data;
wire [31:0] data_mem_out;
wire [31:0] read_data;
wire        mem_write;

instr_mem instr_mem(
    .read_address(instr_address),
    .instr(instr)
);

mips mips(
    .clk(clk),
    .reset(reset),
    .instr_address(instr_address),
    .current_instr(instr),
    .data_mem_read_address(data_mem_read_address),
    .data_mem_write_address(data_mem_write_address),
    .data_mem_write_data(data_mem_write_data),
    .data_mem_out(read_data),
    .mem_write(mem_write)   
);

data_mem data_mem(
    .clk(clk),
    .read_address(data_mem_read_address),
    .write_address(data_mem_write_address),
    .write_data(data_mem_write_data),
    .read_data(read_data),
    .mem_write(mem_write)
);

endmodule