`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2020 05:07:08 PM
// Design Name: 
// Module Name: test_bandaAsamblare
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


module test_bandaAsamblare();
reg clk;
reg[7:0] a;
reg[7:0] b;
reg[7:0] c;
reg[7:0] d;
reg[7:0] e;
reg[7:0] f;
wire[7:0] o;

banda_de_asamblare banda(clk, a, b, c, d, e, f, o);

always #20 clk = ~clk;

initial 
begin 
    clk = 0;
    a = 20; b = 20 ; c = 20; d = 30 ; e = 10 ; f = 5;
    #40 
    a = 3; b = 2 ; c = 50; d = 30 ; e = 110 ; f = 5;
    #40 
    a = 20; b = 20 ; c = 20; d = 30 ; e = 10 ; f = 5;
    #40 
    a = 1; b = 1 ; c = 1; d = 1 ; e = 1 ; f = 1;
    #40 
    a = 40; b = 20 ; c = 25; d = 5 ; e = 10 ; f = 5;
    


end

endmodule
