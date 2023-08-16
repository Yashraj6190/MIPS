module adder(
    input [31:0] a_in,
    input [31:0] b_in,
    output [31:0] adder_out
    );
    
    assign adder_out = a_in + b_in;
    
endmodule