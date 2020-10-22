`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2020 04:28:30 PM
// Design Name: 
// Module Name: banda_de_asamblare
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
module registru1(clk,in1,in2,in3,out1,out2,out3);
input clk ;
input[7:0] in1;
input[7:0] in2;
input[7:0] in3;

output[7:0] out1;
output[7:0] out2;
output[7:0] out3;

reg[7:0] out1;
reg[7:0] out2;
reg[7:0] out3;


always @(posedge clk)
begin
    out1 = in1 ;
    out2 = in2 ;
    out3 = in3 ;
end 
endmodule

module registru2(clk,in1,in2,out1,out2);
input clk ;
input[7:0] in1;
input[7:0] in2;


output[7:0] out1;
output[7:0] out2;


reg[7:0] out1;
reg[7:0] out2;



always @(posedge clk)
begin
    out1 = in1 ;
    out2 = in2 ;

end 
endmodule

module registru3(clk,in1,out1);
input clk ;
input[7:0] in1;
output[7:0] out1;

reg[7:0] out1;

always @(posedge clk)
begin
    out1 = in1 ;

end 
endmodule


module banda_de_asamblare(clk, a, b, c, d, e, f, o);
input clk;
input[7:0] a;
input[7:0] b;
input[7:0] c;
input[7:0] d;
input[7:0] e;
input[7:0] f;
output[7:0] o;

wire[7:0] w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,o;

assign w1 = a / b;
assign w2 = c / d;
assign w3 = e /f;
registru1 r1(clk,w1,w2,w3,w4,w5,w6);

assign w7 = w4 * w5;
registru2 r2(clk,w7,w6,w8,w9);

assign w10 = w8 - w9;
registru3 r3(clk,w10,w11);

assign o = w11;



endmodule
