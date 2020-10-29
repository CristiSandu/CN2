
module simulare1;

reg [7:0] D;
reg [2:0] sel;

wire out ;

mux8_1 mux(D,sel ,out);

initial begin 
#0
    D = 8'b00000001;
    sel= 3'b000;
#50
    D = 8'b00000010;
    sel= 3'b001;
#50 
    D = 8'b00000100;
    sel = 3'b010;
#50
    D = 8'b00001000;
    sel= 3'b011;
#50 
    D = 8'b00010000;
    sel = 3'b100;
#50 
    D = 8'b00100000;
    sel = 3'b101;
#50 
    D = 8'b01000000;
    sel = 3'b110;
#50 
    D = 8'b10000000;
    sel = 3'b111;



end 


endmodule

