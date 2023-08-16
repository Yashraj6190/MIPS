module alu (input wire [31:0] a_in, b_in, input wire [2:0] alu_op, output reg zero_flag, output reg [31:0] alu_result);

reg carry;

always@(*)
begin
  carry = 0;
  case(alu_op)
  3'b000: alu_result = a_in & b_in;  //AND
  3'b001: alu_result = a_in | b_in;  //OR
  3'b010: begin {carry,alu_result} = a_in + b_in; end   //ADD
  3'b110: begin {carry,alu_result} = a_in - b_in; end //SUB
  3'b111: begin  
                if(a_in < b_in)
                    alu_result = 32'b1;    //SLT
                 else
                    alu_result = 32'b0;
            end
  default: alu_result = 31'b0;
  endcase
  zero_flag = ((alu_result == 0) & (carry == 0)) ? 1'b1 : 1'b0; 
end
endmodule