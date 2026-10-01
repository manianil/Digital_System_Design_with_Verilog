module SRLatch (input EN, R, S, output reg Q, Qbar);

always@(*)
begin
if(EN)
	begin
	case({S,R})
	2'b01: Q = 1'b0;
	2'b10: Q = 1'b1;
	2'b11: Q = 1'bx;
	default: Q = Q;
	endcase
	end
Qbar = ~Q;
end 
endmodule

module DLatch (input EN, D, output reg Q, Qbar);

always@(*)
begin
if(EN)
	begin
	Q = D;
	end
Qbar = ~Q;
end 

endmodule

//Dataflow Style
module SRLatchdF (input EN, R, S, output Q, Qbar);

assign Q    = ~((R & EN) | Qbar);
assign Qbar = ~((S & EN) | Q);

endmodule

module DLatchdF (input EN, D, output Q, Qbar);

assign Q    = (D & EN) | Q;
assign Qbar = (~D & EN) | Qbar;

endmodule