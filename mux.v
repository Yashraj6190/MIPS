module mux #(parameter width=32)(
    input [width-1:0] in0,
    input [width-1:0] in1,
    input control,
    output [width-1:0] muxout
    );
    
    assign #1 muxout = (control == 0) ? in0 : in1;
endmodule