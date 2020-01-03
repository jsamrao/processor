/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: ifu.v
# Design: Instruction Fetch Unit 
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/

`timescale 1ns/100ps

module decoder (in, out);

input [3:0] in;
output [12:0] out;

assign out = {o13, o12, o11, o10, o9, o8, o7, o6, o5, o4, o3, o2, o1};


inv inv1( w1, in[0]);
inv inv2( w2, in[1]);
inv inv3( w3, in[2]);
inv inv4( w4, in[3]);

and and1(o1, w4, w3,  w2, w1);
and and2(o2, w4, w3,  w2, in[0]);
and and3(o3, w4, w3,  in[1], w1);
and and4(o4, w4, w3,  in[1], in[0]);
and and5(o5, w4, in[2], w2, w1);
and and6(o6, w4, in[2], w2, in[0]);
and and7(o7, w4, in[2], in[1], w1);
and and8(o8, w4, in[2], in[1], in[0]);
and and9(o9, in[3], w3, w2, w1);
and and10(o10, in[3], w3, w2, in[0]);
and and11(o10, in[3], w3, in[1], w1);
and and12(o11, in[3], w3, in[1], in[0]);
and and13(o12, in[3], in[2], w2, w1);




endmodule


