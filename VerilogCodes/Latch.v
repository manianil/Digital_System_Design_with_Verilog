// Positive Level D Latch
module Pos_Level_DLatch (input D, EN, output reg Q, Qb);

always@(*)
begin
if(EN)
begin Q <= D; end
Qb = ~Q;
end

endmodule


// Positive Level D Latch using case
module Pos_Level_DLatchc (input D, EN, output reg Q, Qb);

always@(*)
begin
case(EN)
1'b0: Q = Q;
1'b1: Q = D;
endcase
Qb = ~Q;
end

endmodule


// Negative Level D Latch
module Neg_Level_DLatch (input D, ENb, output reg Q, Qb);

always@(*)
begin
if(~ENb)
begin Q <= D; end
Qb = ~Q;
end

endmodule

// Negative Level D Latch using case
module Neg_Level_DLatchc (input D, ENb, output reg Q, Qb);

always@(*)
begin
case(ENb)
1'b0: Q = D;
1'b1: Q = Q;
endcase
Qb = ~Q;
end

endmodule
