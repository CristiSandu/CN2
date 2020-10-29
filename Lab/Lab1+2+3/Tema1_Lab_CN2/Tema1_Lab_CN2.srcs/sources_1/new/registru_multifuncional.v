module registru_multifunctional(
    input [3:0] intrare_reg,
    input clk,
    input reset,
    input EN,
    input INC,
    input DEC,
    input SHL,
    input SHR,
    output [3:0] out
);

reg[3:0] out;
reg[3:0] int_reg;

always @( posedge clk or reset )
begin 
        
if (reset)
    out = 4'b0000;
else if (EN == 1)
begin
out = intrare_reg;
end 
else 
begin

        if (INC == 1)
        begin
            out = out + 1; 
        end 
        
        if (DEC == 1)
        begin
            out = out - 1; 
        end 
        
        if (SHL == 1)
        begin
            out = out << 1; 
        end 
        
        if (SHR == 1)
        begin
           out = out >> 1; 
        end 
  end
   
end
 

endmodule