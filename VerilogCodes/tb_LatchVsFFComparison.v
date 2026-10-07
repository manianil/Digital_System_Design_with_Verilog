`timescale 1ns / 1ps
module tb_LatchVsFFComparison();

// Input Signal Declarations
reg Clock, InputData; 

// Output Signal Declarations
wire DL_op, DFF_op;

// DUT Instantiation
Pos_Level_DLatch U1 (.D(InputData), .EN(Clock), .Q(DL_op), .Qb());   // +ve Level D  Latch
PosEdge_DFF U2 (.D(InputData), .CLK(Clock), .Q(DFF_op), .Qb());      // +ve Edge D F/F

// Initialize the input values & Monitor outputs in terminal
initial 
begin
Clock=0; InputData=0;
$monitor("Time = %0t | Clock = %b | InputData = %b | Latch Output = %b | D F/F Output = %b ", $time, Clock, InputData, DL_op, DFF_op);
end

// Start the test bench
always
begin
#20 Clock = ~Clock; // Clock Period is 40ns
end

initial 
begin
#30 InputData=1;
#5 InputData=0;
#10 InputData=1;
#5 InputData=0;
#10 InputData=1;
#50 InputData=0;
#80 InputData=1;
#80 InputData=0;
#100 $finish();
end

endmodule
