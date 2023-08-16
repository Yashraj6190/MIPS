module cu(input wire [5:0] op_code, input wire [5:0] op_funct, input zero_in,
          output reg reg_dst, reg_write, alu_src, mem_write, mem_to_reg, output wire pc_src, output reg [2:0] alu_op);

wire add_wire, sub_wire, and_wire, or_wire, slt_wire, lw_wire, sw_wire, bne_wire, add_imm_wire, slt_imm_wire, and_imm_wire, or_imm_wire;

assign add_wire = ((op_code == 6'b000000) && (op_funct==6'b100000)) ? 1'b1 : 1'b0;
assign sub_wire = ((op_code == 6'b000000) && (op_funct==6'b100010)) ? 1'b1 : 1'b0;
assign and_wire = ((op_code == 6'b000000) && (op_funct==6'b100100)) ? 1'b1 : 1'b0;
assign or_wire = ((op_code == 6'b000000) && (op_funct==6'b100101)) ? 1'b1 : 1'b0;
assign slt_wire = ((op_code == 6'b000000) && (op_funct==6'b101010)) ? 1'b1 : 1'b0;
assign lw_wire = (op_code == 6'b100011) ? 1'b1 : 1'b0;
assign sw_wire = (op_code == 6'b101011) ? 1'b1 : 1'b0;
assign bne_wire = (op_code == 6'b000101) ? 1'b1 : 1'b0;
assign add_imm_wire = (op_code == 6'b001000) ? 1'b1 : 1'b0;
assign slt_imm_wire = (op_code == 6'b001010) ? 1'b1 : 1'b0;
assign and_imm_wire = (op_code == 6'b001100) ? 1'b1 : 1'b0;
assign or_imm_wire = (op_code == 6'b001101) ? 1'b1 : 1'b0;
assign pc_src = bne_wire & zero_in;

always@(*)
begin
    if(add_wire)
        begin
            reg_dst = 1'b1;
            reg_write = 1'b1;
            alu_src = 1'b0;
            alu_op = 3'b010;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
        end
    else if(sub_wire)
        begin
            reg_dst = 1'b1;
            reg_write = 1'b1;
            alu_src = 1'b0;
            alu_op = 3'b110;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
        end
    else if(and_wire)
        begin
            reg_dst = 1'b1;
            reg_write = 1'b1;
            alu_src = 1'b0;
            alu_op = 3'b000;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
        end
    else if(or_wire)
        begin
            reg_dst = 1'b1;
            reg_write = 1'b1;
            alu_src = 1'b0;
            alu_op = 3'b001;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
        end
    else if(slt_wire)
        begin
            reg_dst = 1'b1;
            reg_write = 1'b1;
            alu_src = 1'b0;
            alu_op = 3'b111;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
        end
    else if(lw_wire)
        begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            alu_src = 1'b1;
            alu_op = 3'b010;
            mem_write = 1'b0;
            mem_to_reg = 1'b1;
        end
    else if(sw_wire)
        begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            alu_src = 1'b1;
            alu_op = 3'b010;
            mem_write = 1'b1;
            mem_to_reg = 1'b0;
        end
    else if(bne_wire)
        begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            alu_src = 1'b0;
            alu_op = 3'b110;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
        end
    else if(add_imm_wire)
        begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            alu_src = 1'b1;
            alu_op = 3'b010;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;     
        end
    else if(slt_imm_wire)
        begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            alu_src = 1'b1;
            alu_op = 3'b111;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;     
        end
    else if(and_imm_wire)
        begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            alu_src = 1'b1;
            alu_op = 3'b000;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;     
        end
    else if(or_imm_wire)
        begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            alu_src = 1'b1;
            alu_op = 3'b001;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;     
        end
    else
        begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            alu_src = 1'b0;
            alu_op = 3'b000;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
        end
end

endmodule