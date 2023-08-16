module pc(
    input clk,
    input reset,
    input [31:0] pc_in,
    output reg [31:0] instr_address
    );
    

always @(posedge clk or posedge reset)
begin
    if(reset)
        instr_address <= 0;
    else
        instr_address <= pc_in;
end    
    
endmodule