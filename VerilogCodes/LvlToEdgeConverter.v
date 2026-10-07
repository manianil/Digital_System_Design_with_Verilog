`timescale 1ns/10ps
module LvlToEdgeConverter (input SigIn, output reg PEdge, NEdge, EEdge);

reg I1;

always@(*)
begin
#0.5 I1 = ~SigIn;  // Delay will be considered only in simulation
end


always@(*)
begin
PEdge = SigIn & I1;    // Detects the +ve Edge
NEdge = ~(SigIn | I1); // Detects the -ve Edge
EEdge = PEdge | NEdge; // Detects both Edges 
end

endmodule


