/*
Write a code for a Full-Adder using Dataflow style: Use arithmetic operators
*/

module FullAdder (input A, B, Cin, output Co, S);

assign {Co, S} = A + B + Cin;  // Using Concatenation & Arithmetic Operators

endmodule