/*
Design a 4 bit binary adder using Structural style 
	  i) First create a gate level Full-Adder 
	 ii) Create the 4-bit Full adder using 4 1-bit adders designed above
	iii) Write a testbench to check all combinations
*/

// Test Bench Code
`timescale 10ns/10ns
module TB_FullAdderNbit();

reg [3:0] InA, InB;
reg InCin;
wire [4:0] SystemOut;
integer i, j;

FullAdderNbit #(.BitSize(4)) DUT (.A(InA), .B(InB), .Cin(InCin),.Co(SystemOut[4]), .S(SystemOut[3:0]));

initial
begin
	$monitor("Time=%0t | Cin=%b | A=%d (%b) | B=%d (%b) | Sum+Co=%d (%b)", $time, InCin, InA, InA, InB, InB, SystemOut, SystemOut);
	InCin=1'b0;
	for(i=0; i<16; i=i+1)
	begin
		InA=i;
		for(j=0; j<16; j=j+1)
		begin
		InB=j;
		#10;
		end
	end
	InCin=1'b1;
	for(i=0; i<16; i=i+1)
	begin
		InA=i;
		for(j=0; j<16; j=j+1)
		begin
		InB=j;
		#10;
		end
	end
	$display("--- All 512 test cases completed successfully! ---");
	$finish; // End simulation
end

endmodule

// 4-bit (N-bit Parameterized) Full Adder
module FullAdderNbit #(
    parameter BitSize = 4
) (
    input  wire [BitSize-1:0] A,
    input  wire [BitSize-1:0] B,
    input  wire               Cin,
    output wire               Co,
    output wire [BitSize-1:0] S
);
genvar i;

wire [BitSize:0] Cint;

assign Cint[0]=Cin;
assign Co=Cint[BitSize];

generate
for(i=0; i<BitSize; i=i+1)
begin
FA U_FA (.A(A[i]), .B(B[i]), .Cin(Cint[i]), .Co(Cint[i+1]), .S(S[i]));
end
endgenerate

endmodule


// Full Adder
module FA (input A, B, Cin, output Co, S);

wire n1, n2, n3;

xor U1 (n1, A, B); // Two input ex-or gate implementing n1 = A ^ B
xor U2 (S, n1, Cin); // Two input ex-or gate implementing S = n1 ^ Cin = A ^ B ^ Cin

and U3 (n2, A, B); // Two input and gate implementing n2 = A & B
and U4 (n3, n1, Cin); // Two input and gate implementing n3 = n1 & Cin =  (A ^ B)& Cin
or U5 (Co, n2, n3);

endmodule