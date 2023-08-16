module shift_left #(parameter shift_amount = 2)(
    input [31:0] in,
    output [31:0] out
    );
    
    assign out = in << shift_amount;
endmodule