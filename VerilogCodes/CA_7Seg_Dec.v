/*
Design, model, and implement a 4-bit Hexadecimal-to-7-Segment Decoder for the Spartan-7 FPGA on the Boolean Board. The circuit must convert a 4-bit binary input (SW_3, SW_2, SW_1, SW_0) into the correct 7-bit active-low segment code (ca, cb, cc, cd, ce, cf, cg) to display values 0 through F on of the display. SW_15, SW_14 to be used to select the Digit (00-Digit0, 01 Digit1 and so on)
*/


module CA_7Seg_Dec (
					input [1:0] Digit, 
					input [3:0] B, 
					input DecPt, 
					output reg [7:0] SEG, 
					output reg [3:0] AN);
always@(*)
begin
case(B)
 0: SEG = {~DecPt, 7'b1000000};  1: SEG = {~DecPt, 7'b1111001};
 2: SEG = {~DecPt, 7'b0100100};  3: SEG = {~DecPt, 7'b0110000}; 
 4: SEG = {~DecPt, 7'b0011001};  5: SEG = {~DecPt, 7'b0010010};
 6: SEG = {~DecPt, 7'b0000010};  7: SEG = {~DecPt, 7'b1111000};
 8: SEG = {~DecPt, 7'b0000000};  9: SEG = {~DecPt, 7'b0010000};
10: SEG = {~DecPt, 7'b0001000}; 11: SEG = {~DecPt, 7'b0000011};
12: SEG = {~DecPt, 7'b1000110}; 13: SEG = {~DecPt, 7'b0100001};
14: SEG = {~DecPt, 7'b0000110}; 15: SEG = {~DecPt, 7'b0001110};
default: SEG = 8'hFF;
endcase

case(Digit)
0: AN = 4'b1110; 1: AN = 4'b1101; 2: AN = 4'b1011; 3: AN = 4'b0111;
endcase
end
endmodule