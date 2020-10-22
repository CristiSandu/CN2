
module simulare1;

reg [7:0] D;
reg [2:0] sel;

wire out ;

mux8_1 mux(D,sel ,out);

initial begin 
#0
    D = 8'b10010101;
    sel= 3'b101;
#50
    D = 8'b10010101;
    sel= 3'b101;
#50 
    D = 8'b11111111;
    sel = 3'b001;
#50
    D = 8'b10010101;
    sel= 3'b101;
#50 
    D = 8'b11111111;
    sel = 3'b001;
#50 
    D = 8'b00000001;
    sel = 3'b010;


end 


endmodule

/*
module test_registru_multifunctional;
    reg [3:0] intrare;
    reg clk,rst;
    reg [4:0] intrarile_pe_1_bite;
    
    wire [3:0] out;
    
    
    
    registru_multifunctional reg1( intrare,
    clk,
    rst,
    intrarile_pe_1_bite[4],
    intrarile_pe_1_bite[3],
    intrarile_pe_1_bite[2],
    intrarile_pe_1_bite[1],
    intrarile_pe_1_bite[0],
    out);
    
initial begin
    clk = 1'b0;
    rst = 1'b1;
    repeat(4) #10 clk = ~clk;
    rst = 1'b0;
    forever #10 clk = ~clk;
end     
    
initial begin 
#0
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b10000;
#50
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b01000;
#50 
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b00100;
#50
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b00010;
#50 
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b00001;
#50 
   intrare = 4'b1001; 
   intrarile_pe_1_bite = 5'b10001;


end 

endmodule
*/