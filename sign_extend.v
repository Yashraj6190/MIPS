module sign_extend(
    input [15:0] in,
    output [31:0] out
    );
    
    
    assign out[15:0] = in[15:0];
    assign out[31:16] = {16{in[15]}};
endmodule