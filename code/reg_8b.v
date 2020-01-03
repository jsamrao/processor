/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: reg_8b.v
# Design: 8-b Register
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/


module reg_8b (clk, rst, d, q);

input clk;
input rst;

input [7:0] d;
output [7:0] q;


dff ff0 (q[0], d[0], clk, rst);
dff ff1 (q[1], d[1], clk, rst);
dff ff2 (q[2], d[2], clk, rst);
dff ff3 (q[3], d[3], clk, rst);
dff ff4 (q[4], d[4], clk, rst);
dff ff5 (q[5], d[5], clk, rst);
dff ff6 (q[6], d[6], clk, rst);
dff ff7 (q[7], d[7], clk, rst);

endmodule

module dff(d, q, clk, rst);
input clk, rst, d;
output q;

always @ (posedge clk) begin
  if (~rst)
     q <= 1'b0;
  else 
     q <= d;
end

endmodule
