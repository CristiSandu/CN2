`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 05:02:11 PM
// Design Name: 
// Module Name: adder
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

module adder(ina,inb,out);
//parameter N=32;
input [31:0] ina,inb;
   output [31:0] out;
/*   wire  carry_out;
  wire [31:0] carry;
   genvar i;
   generate 
   for(i=0;i<31;i=i+1)
     begin: generate_N_bit_Adder
   if(i==0) 
  half_adder f(ina[0],inb[0],out[0],carry[0]);
   else
  full_adder f(ina[i],inb[i],carry[i-1],out[i],carry[i]);
     end
  assign carry_out = carry[31];
   endgenerate
   assign out[31] = carry_out;*/
   
   assign out = ina + inb;
endmodule 

// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for N-bit Adder 
// Verilog code for half adder 
module half_adder(x,y,s,c);
   input x,y;
   output s,c;
   assign s=x^y;
   assign c=x&y;
endmodule // half adder

// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for N-bit Adder 
// Verilog code for full adder 
module full_adder(x,y,c_in,s,c_out);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule // full_adder
