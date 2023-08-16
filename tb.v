`timescale 1ns/1ns
`include "complete.v"

module tb();

reg clk;
reg reset;


initial
begin
    reset = 1;
    #10;
    reset = 0;
end

initial
begin
    clk = 0;
    forever
    begin
        clk = ~clk;
        #5;
    end
end


complete dut(
    .clk(clk),
    .reset(reset)
);

initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, dut);
    end

initial begin
        #1000000
        $finish;
    end

endmodule