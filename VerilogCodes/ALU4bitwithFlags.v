/*
Design a 4-bit ALU that implements the following set of operations with Overflow, Carry, Borrow and Zero Flags
*/
module ALU4bitwithFlags (input [3:0] A, B, input [2:0] Mode, output reg [3:0] F, output reg CF, BF, ZF, OF);
reg [4:0] Result;

always@(*)
begin
	{CF, BF, OF, ZF}= 4'b0000; // default values
case(Mode)
3'b000:	begin 
		Result = A + B; // A + B
		CF = Result[4];
		OF = (A[3] == B[3]) && (Result[3] != A[3]); // A B same sign but result is different sign
		end
3'b001: begin 
		Result = A - B; // A - B
		BF = A < B; // Borrow occurs if B is larger than A
		OF = (A[3] != B[3]) && (Result[3] != A[3]); // A & B are different signs but result is different sign from A
		end
3'b010: begin 
		Result = A + 1'b1; // Increment A
		CF = Result[4]; 
		OF = (A == 4'b0111) ; // A changes sign
		end
3'b011: begin 
		Result = A - 1'b1; // Decrement A
		BF = (A == 4'b0000); // Borrow occurs when 1 is larger than A 
		OF = (A == 4'b1000) ; // A changes sign
		end
3'b100: begin 
		Result = {1'b0, A} << 1 ; // A * 2
		CF = A[3]; // MSB is the Carry
		end
3'b101: Result = {1'b0, A} >> 1 ; // A / 2
3'b110: Result = {1'b0, A & B}; // A and B
3'b111: Result = {1'b0, A | B}; // A or B
endcase
F  = Result[3:0];
ZF = (F == 4'b0000); // Zero flag set if output is all zeros
end
endmodule