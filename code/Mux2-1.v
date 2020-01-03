`timescale 1ns/100ps


module Mux2to1_1b(in0, in1, sel, out);

input in0, in1;
input sel;
output out;

not inv1(selp, sel);
and(w2, in0, selp);
and(w3, in1, sel);

or or3( out, w2, w3);


endmodule

module Mux2to1_8b(in0, in1, sel, out);

input [7:0] in0, in1;
input sel;
output [7:0] out;

Mux2to1_1b mux_b0 (in0[0], in1[0], sel, out[0]);
Mux2to1_1b mux_b1 (in0[1], in1[1], sel, out[1]);
Mux2to1_1b mux_b2 (in0[2], in1[2], sel, out[2]);
Mux2to1_1b mux_b3 (in0[3], in1[3], sel, out[3]);
Mux2to1_1b mux_b4 (in0[4], in1[4], sel, out[4]);
Mux2to1_1b mux_b5 (in0[5], in1[5], sel, out[5]);
Mux2to1_1b mux_b6 (in0[6], in1[6], sel, out[6]);
Mux2to1_1b mux_b7 (in0[7], in1[7], sel, out[7]);

endmodule

