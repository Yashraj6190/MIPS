module data_mem (
    input clk,
    input [31:0] read_address,
    input [31:0] write_address,
    input [31:0] write_data,
    output [31:0] read_data,
    input mem_write
);
parameter propDelay=2;

reg [31:0] ram_mem [20:0];

assign #propDelay read_data =  ram_mem[read_address];

always @(posedge clk)
begin
    if(mem_write)
        ram_mem[write_address] <= write_data;
end


endmodule