`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2020 04:13:37 PM
// Design Name: 
// Module Name: mux8_1
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
/*
module myand(
input a,
input b,
output out
);

assign out = a & b;

endmodule 


module mux2_1(
input a,
input b,
input sel,
output o
);

wire a, b ,c;



myand i1(a,~sel, a);
myand i2(b ,sel ,b);

myor i3(a ,b, c);

    
endmodule
*/


module mux8_1(
input [7:0] D,
input [2:0] sel,
output out
    );
    
 assign out =( (D[0] & ~sel[2] &  ~sel[1] & ~sel[0])|
 (D[1] & ~sel[2]  & ~sel[1] & sel[0]) | 
 (D[2] & ~sel[2]  & sel[1] & ~sel[0]) | 
 (D[3] & ~sel[2]  & sel[1] & sel[0]) | 
 (D[4] & sel[2]  & ~sel[1] & ~sel[0]) | 
 (D[5] & sel[2]  & ~sel[1] & sel[0]) | 
 (D[6] & sel[2]  & sel[1] & ~sel[0]) | 
 (D[7] & sel[2]  & sel[1] & sel[0])) ; 
    
    
endmodule
