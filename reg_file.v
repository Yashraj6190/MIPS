module reg_file ( input clk, input [4:0] read_address_1, read_address_2, write_address, input [31:0] write_data, input reg_write_en, 
                  output reg [31:0] read_data_1, read_data_2);

reg [31:0] t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, s0, s1, s2 ,s3 ,s4 ,s5, s6, s7;

always@(posedge clk)
begin
    if (reg_write_en)
    begin
        case (write_address)
         8: t0 <= write_data;   //the constant value zero
         9: t1 <= write_data;   //temporaries
        10: t2 <= write_data;   //temporaries
        11: t3 <= write_data;   //temporaries
        12: t4 <= write_data;   //temporaries
        13: t5 <= write_data;   //temporaries
        14: t6 <= write_data;   //temporaries
        15: t7 <= write_data;   //temporaries
        16: s0 <= write_data;   //saved (by callee)
        17: s1 <= write_data;   //saved (by callee)
        18: s2 <= write_data;   //saved (by callee)   
        19: s3 <= write_data;   //saved (by callee)
        20: s4 <= write_data;   //saved (by callee)
        21: s5 <= write_data;   //saved (by callee)
        22: s6 <= write_data;   //saved (by callee)
        23: s7 <= write_data;   //saved (by callee)
        24: t8 <= write_data;   //more temporaries
        25: t9 <= write_data;   //more temporaries
        endcase
    end
end

always@(*)
begin
    case (read_address_1)
      0: read_data_1 = 0;
     8: read_data_1 = t0;
     9: read_data_1 = t1;
    10: read_data_1 = t2;
    11: read_data_1 = t3;
    12: read_data_1 = t4;
    13: read_data_1 = t5;
    14: read_data_1 = t6;
    15: read_data_1 = t7;
    16: read_data_1 = s0;
    17: read_data_1 = s1;
    18: read_data_1 = s2;
    19: read_data_1 = s3;
    20: read_data_1 = s4;
    21: read_data_1 = s5;
    22: read_data_1 = s6;
    23: read_data_1 = s7;
    24: read_data_1 = t8;
    25: read_data_1 = t9;
    default: read_data_1 = 'hxx;
    endcase
end

always@(*)
begin
    case (read_address_2)
      0: read_data_2 = 0;
     8: read_data_2 = t0;
     9: read_data_2 = t1;
    10: read_data_2 = t2;
    11: read_data_2 = t3;
    12: read_data_2 = t4;
    13: read_data_2 = t5;
    14: read_data_2 = t6;
    15: read_data_2 = t7;
    16: read_data_2 = s0;
    17: read_data_2 = s1;
    18: read_data_2 = s2;
    19: read_data_2 = s3;
    20: read_data_2 = s4;
    21: read_data_2 = s5;
    22: read_data_2 = s6;
    23: read_data_2 = s7;
    24: read_data_2 = t8;
    25: read_data_2 = t9;
    default: read_data_2 = 'hxx;
    endcase
end

endmodule