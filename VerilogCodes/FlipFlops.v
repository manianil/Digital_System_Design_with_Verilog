// -ve Edge Triggered Master-Slave D Flipflop 

module NegEdge_DFF (input D, CLK, output Q, Qb);
wire Qm;

Pos_Level_DLatch U1 (.D(D), .EN(CLK), .Q(Qm), .Qb());
Pos_Level_DLatch U2 (.D(Qm), .EN(~CLK), .Q(Q), .Qb(Qb));

endmodule

// +ve Edge Triggered Master-Slave D Flipflop  
module PosEdge_DFF (input D, CLK, output Q, Qb);
wire Qm;

Pos_Level_DLatch U2 (.D(D), .EN(~CLK), .Q(Qm), .Qb());
Pos_Level_DLatch U1 (.D(Qm), .EN(CLK), .Q(Q), .Qb(Qb));

endmodule


// +ve Edge Triggered Pseudo D Flipflop  using Edge Detector 
module PosEdge_DFF_Edge (input D, CLK, output Q, Qb);
wire PEdge;

LvlToEdgeConverter U1 (.SigIn(CLK), .PEdge(PEdge), .NEdge(), .EEdge());
Pos_Level_DLatch U2 (.D(D), .EN(PEdge), .Q(Q), .Qb(Qb));


endmodule

// +ve Edge Triggered D Flipflop  with Asynchronous Active low reset
module DFF_ARst (input Rn, Clk, D, output reg Q, Qn);

always@(posedge Clk or negedge Rn)
begin
	if(!Rn)
		begin
		Q <= 1'b0;
		end
	else 
		begin
		Q <= D;
		end
end

always@(*)
begin
Qn=~Q;
end

endmodule

// +ve Edge Triggered D Flipflop  with Asynchronous Active low Preset & Reset
module DFF_ARstPst (input Rn, Pn, Clk, D, output reg Q, Qn);

always@(posedge Clk or negedge Rn or negedge Pn)
begin
	if(!Rn)
		begin
		Q <= 1'b0;
		end
	else if (!Pn)
		begin
		Q <= 1'b1;
		end	
	else 
		begin
		Q <= D;
		end
end

always@(*)
begin
Qn=~Q;
end

endmodule

// +ve Edge Triggered D Flipflop  with Asynchronous Active low Preset & Reset and Synchronous Enable
module DFF_ARstPstEn (input Rn, Pn, Clk, EN, D, output reg Q, Qn);

always@(posedge Clk or negedge Rn or negedge Pn)
begin
	if(!Rn)
		begin Q <= 1'b0; end  // Reset
	else if (!Pn)
		begin Q <= 1'b1; end  // Preset
	else if (EN)
		begin Q <= D; end     // update
	else
		begin Q <= Q; end     // store
end

always@(*)
begin Qn=~Q; end

endmodule


// J K FlipFlop

module JK_FF (input J, K, Clock, output reg Q);

always@(posedge Clock)
begin
Q <= (J & ~Q) |  (~K & Q) ;
end

endmodule

module JK_FF_case (input J, K, Clock, output reg Q);

always@(posedge Clock)
begin
case({J,K})
2'b00: Q<=Q;
2'b01: Q<=1'b0;
2'b10: Q<=1'b1;
2'b11: Q<=~Q;
endcase
end

endmodule


module JK_FF_if (input J, K, Clock, output reg Q);

always@(posedge Clock)
begin
if({J,K} == 2'b00) Q <= Q;
else if ({J,K} == 2'b01) Q <= 1'b0;
else if ({J,K} == 2'b10) Q <= 1'b1;
else  Q <= ~Q;
end

endmodule

`timescale 1ns / 1ps

module tb_JK_FF;

    // Inputs
    reg J;
    reg K;
    reg Clock;

    // Outputs
    wire Q1, Q2, Q3;

    // Instantiate the Unit Under Test (UUT)
    JK_FF uut (
        .J(J), 
        .K(K), 
        .Clock(Clock), 
        .Q(Q1)
    );
	
	    JK_FF_case uut2 (
        .J(J), 
        .K(K), 
        .Clock(Clock), 
        .Q(Q2)
    );
	
		JK_FF_if uut3 (
        .J(J), 
        .K(K), 
        .Clock(Clock), 
        .Q(Q3)
    );

    // Clock generation: 10ns period (100MHz)
    always #5 Clock = ~Clock;

    initial begin
        // Initialize Inputs
        Clock = 0;
        J = 0;
        K = 0;
        // Monitor outputs continuously
        $monitor("Time = %0t | J = %b | K = %b | Q1 = %b | Q2 = %b | Q3 = %b |", $time, J, K, Q1, Q2, Q3);
        #10;   
        // Set Mode (J=1, K=0)
        J = 1; K = 0;
        #10; // Q should become 1 on posedge
        // Hold Mode (J=0, K=0)
        J = 0; K = 0;
        #10; // Q should remain 1
        //Reset Mode (J=0, K=1)
        J = 0; K = 1;
        #10; // Q should become 0 on posedge
        // Hold Mode (J=0, K=0)
        J = 0; K = 0;
        #10; // Q should remain 0
        // Toggle Mode (J=1, K=1) 
        J = 1; K = 1;
        #10; // Q should toggle to 1
        #10; // Q should toggle to 0
        #10; // Q should toggle to 1
        //Hold Mode
        J = 0; K = 0;
        #10; // Q should stay at current state
        $display("Simulation complete.");
        $finish;
    end
      
endmodule
