/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: alu.v
# Design: Arithmetic and Logic Unit
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/


module alu (cf_sel_i,  alu_sel_0_i,  alu_sel_1_i,  inv_sel_i,  shftr_sel_i,  shftl_sel_i, oprnd_0_i, oprnd_1_i, alu_result_o, cf_o);


input       cf_sel_i;
input       alu_sel_0_i;
input [1:0] alu_sel_1_i;
input       inv_sel_i;
input       shftr_sel_i;
input       shftl_sel_i;

input [7:0]  oprnd_0_i;
input [7:0]  oprnd_1_i;
output [7:0] alu_result_o;

output      cf_o;






endmodule
