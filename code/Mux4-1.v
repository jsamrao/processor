`timescale 1ns/100ps

module Mux4to1_1b (in0, in1, in2, in3, sel, out);

input	in0, in1, in2, in3;
input [1:0] sel;
output	out;

wire s0p, s1p, w3, w4, w5, w6, w7, w8;


not inv1(s0p, s0);

not inv2(s1p, s1);



and and1(w3, in0, s1p, s0p);

and and2(w4, in1, s1p, sel[0]);

or or1(w7, w3, w4);



and and3(w5, in2, sel[1], s0p);

and and4(w6, in3, sel[1], sel[0]);

or or2(w8, w5, w6);


or or3(out, w7, w8);


endmodule 


module Mux4to1_8b (in0, in1, in2, in3, sel, out);

input [7:0] in0, in1, in2, in3;
input [1:0] sel;
output [7:0] out;


Mux4to1_1b mux_b0 (in0[0], in1[0], in2[0], in3[0], sel, out[0]);
Mux4to1_1b mux_b1 (in0[1], in1[1], in2[1], in3[1], sel, out[1]);
Mux4to1_1b mux_b2 (in0[2], in1[2], in2[2], in3[2], sel, out[2]);
Mux4to1_1b mux_b3 (in0[3], in1[3], in2[3], in3[3], sel, out[3]);
Mux4to1_1b mux_b4 (in0[4], in1[4], in2[4], in3[4], sel, out[4]);
Mux4to1_1b mux_b5 (in0[5], in1[5], in2[5], in3[5], sel, out[5]);
Mux4to1_1b mux_b6 (in0[6], in1[6], in2[6], in3[6], sel, out[6]);
Mux4to1_1b mux_b7 (in0[7], in1[7], in2[7], in3[7], sel, out[7]);




endmodule


