`timescale 1ns / 1ps

module registers(input clk, reg_write,
                 input [4:0] read_reg1, read_reg2, write_reg,
                 input [31:0] write_data,
                 output [31:0] read_data1, read_data2
    );
    reg [31:0] x[31:0];
    reg [31:0] out_read1, out_read2;
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            x[i] = i;
        end
    end
    
    always@(read_reg1) begin
        out_read1 = x[read_reg1];
    end
    
    assign read_data1 = out_read1;
    
    always@(read_reg2) begin
        out_read2 = x[read_reg2];
    end
    
    assign read_data2 = out_read2;
    
    always@(posedge clk) begin
        if (reg_write == 1) begin
            x[write_reg] = write_data;
        end
    end
    
endmodule
