`timescale 1ns / 1ps
module tb_Decoder3to8();
    // Testbench signals
    reg [2:0] S;
    reg En;
    wire [7:0] YH, YL;
    integer i;
	// DUT Instantiation
    Decoder3to8AH Dut1 (.S(S), .En(En), .Y(YH)); // Active-High Decoder
	Decoder3to8AL Dut2 (.S(S), .En(En), .Y(YL)); // Active-Low Decoder
	// Start the test bench
    initial begin
        // Monitor outputs in terminal
        $monitor("Time = %0t | En = %b | S = %b (%0d) | YH = %b | YL = %b", $time, En, S, S, YH, YL);
        // Enable is OFF (En = 0)
        // Output Y, regardless of S, should remain 
		// 8'b00000000 for Active-High, and 
		// 8'b11111111 for Active-Low
        En = 0;
        S = 3'b000;
        #10;
        for (i = 0; i < 8; i = i + 1) begin
            S = i; 
            #10;
        end
        // Enable is ON (En = 1)
        // Output Y should set bit Y[S] high for Active-High
		// Output Y should reset bit Y[S] high for Active-Low
        En = 1;     
        for (i=0; i<8; i=i+1) begin
            S = i;
            #10;
        end      
        $finish; // Ending simulation
    end

endmodule


// 3-to-8 Line Decoder (Active-High Output)
module Decoder3to8AH (input [2:0] S, input En, output reg [7:0] Y);

always@(*)
begin
Y = 8'b0000_0000;
Y[S] = En;
end

endmodule

// 3-to-8 Line Decoder (Active-Low Output)
module Decoder3to8AL (input [2:0] S, input En, output reg [7:0] Y);

always@(*)
begin
Y = 8'b1111_1111;
Y[S] = ~En;
end

endmodule


// 2-to-4 Line Decoder (Active-High Output)
module Decoder2to4AH (input [1:0] S, input En, output reg [3:0] Y);

always@(*)
begin
Y = 4'b0000;
Y[S] = En;
end

endmodule

module Decoder2to4AHDF (input w0, w1, input En, output Y0, Y1, Y2, Y3);

assign Y0 = En & ~w1 & ~w0;
assign Y1 = En & ~w1 & w0;
assign Y2 = En & w1 & ~w0;
assign Y3 = En & w1 & w0;

endmodule




