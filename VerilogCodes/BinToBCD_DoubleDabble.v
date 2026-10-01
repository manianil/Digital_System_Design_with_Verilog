// 8-bit Binary to BCD conversion using Double Dabble method 
module BinToBCD_DoubleDabble (input [7:0] BinNum, output reg [3:0] Hundreds, Tens, Units);

reg [19:0] InternalReg;
integer i;

always@(*)
begin
InternalReg = {12'b0000_0000_0000, BinNum};  // Making BCD digits to zero and appending the Bin Input

for(i=0; i<8; i=i+1)
	begin
	if(InternalReg[11:8] >4)
		begin
		InternalReg[11:8] = InternalReg[11:8] +3;
		end

	if(InternalReg[15:12] >4)
		begin
		InternalReg[15:12] = InternalReg[15:12] +3;
		end

	if(InternalReg[19:16] >4)
		begin
		InternalReg[19:16] = InternalReg[19:16] +3;
		end

	InternalReg = {InternalReg[18:0], 1'b0};
	end

{Hundreds, Tens, Units} = InternalReg[19:8];
end

endmodule

`timescale 1ns/100ps
module TB_BinToBCD_DoubleDabble();
reg [7:0] DataIn;
wire [3:0] H, T, U;
integer i;

BinToBCD_DoubleDabble DUT (.BinNum(DataIn), .Hundreds(H), .Tens(T), .Units(U));

initial 
begin
// Test Absolute Boundaries
DataIn=8'h00;
#10 DataIn=8'hFF;
// Test Digit threshold
#10 DataIn=8'h09; // 09
#10 DataIn=8'h0A; // 10
#10 DataIn=8'h63; // 99
#10 DataIn=8'h64; // 100
#10 DataIn=8'hC7; // 199
#10 DataIn=8'hC8; // 200
//Walking one
for(i=0; i<8; i=i+1)
	begin
	#10 DataIn= (8'h01 << i);
	end
// Other edge cases
#10 DataIn=8'h07; // 07
#10 DataIn=8'h05; // 05
#10 DataIn=8'h77; // 119
#10 DataIn=8'hE7; // 231
#10 $finish();
end

endmodule