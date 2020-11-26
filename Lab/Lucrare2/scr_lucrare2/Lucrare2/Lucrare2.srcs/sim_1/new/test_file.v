`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 04:43:24 PM
// Design Name: 
// Module Name: test_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_file;
/*
reg [9:0] address;
wire [31:0] instruction;


instruction_memory ins(
                    address,
                    instruction
                        );
                        
 initial begin 
 
 address = 10'b00_0000_0001;
#50 
 address = 10'b00_0000_0011;
 end
*/
/*
reg [31:0] ina,inb;
wire [31:0] out;

adder add(ina,inb,out);
 initial begin 
 
 ina = 1209;
 inb = 4565;

#50; 
 end*/
/* 
reg clk,reset;
reg PCSrc, PC_write;
reg [31:0] PC_Branch;
wire [31:0] PC_IF, INSTRUCTION_IF;

IF iff(
clk,reset,
PCSrc, PC_write,
PC_Branch,
PC_IF, INSTRUCTION_IF
    );

always #10 clk = ~clk;

  initial begin
    #0 clk=1'b0;
       reset=1'b1;
       
       PCSrc = 1'b0;
       PC_write = 1'b1;    
       PC_Branch = 32'b0;  
       
    
    
  
  end
*/   
  /*  
reg [31:0] ina,inb;
reg sel;
wire [31:0] out;     
    
    
mux2_1 mmu(
ina,inb,
sel,
out  );

initial begin 
#0
sel = 1'b0;
ina = 32'b00000000000000000000000000000001;
inb = 32'b00000000000000000000000000000011;
#100;


end

*/

// simulare registers ex3
reg clk, reg_write;
reg [4:0] read_reg1, read_reg2, write_reg;
reg [31:0] write_data;
wire [31:0] read_data1, read_data2;


registers regs(clk,reg_write,
                 read_reg1, read_reg2, write_reg,
                 write_data,
                 read_data1, read_data2
    );

always #10 clk = ~clk; 

initial begin 
  clk = 0;
  reg_write = 1;
  read_reg1 = 5'b00001;
  read_reg2 = 5'b00010;
  write_reg = 5'b00011;
  write_data = 32'b00000000000000000000000000000101;
  #50
  reg_write = 1;
  read_reg1 = 5'b00001;
  read_reg2 = 5'b00010;
  write_reg = 5'b000001;
  write_data = 32'b00000000000000000000000000000111;
  #50
  reg_write = 1;
  read_reg1 = 5'b00001;
  read_reg2 = 5'b00011;
  write_reg = 5'b000001;
  write_data = 32'b00000000000000000000000000010111;
  #50
  reg_write = 1;
  read_reg1 = 5'b00011;
  read_reg2 = 5'b00010;
  write_reg = 5'b000001;
  write_data = 32'b00000000000000000000000000000111;
   #50
  reg_write = 0;
  read_reg1 = 5'b00011;
  read_reg2 = 5'b00010;
  write_reg = 5'b000011;
  write_data = 32'b00000000000000000000000000000111;
   
end
 
 
 // imm_gen simulation 
 /*
 reg [31:0] in; 
 wire [31:0] out;
 
 imm_gen gen(in,out);
 initial begin 
    in = 32'b0000_0000_0001_0000_1110_0010_0001_0011;
 end
*/

   
endmodule
