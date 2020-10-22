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
        int_reg = intrare_reg;
        if (INC == 1)
        begin
            out = int_reg + 1; 
        end 
        else if (DEC == 1)
        begin
            out = int_reg - 1; 
        end 
        else if (SHL == 1)
        begin
            out = int_reg << 1; 
        end 
        else if (SHR == 1)
        begin
           out = int_reg >> 1; 
        end 
        else
        out = int_reg;
   end 
end
 

endmodule