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
input [1:0] alu_sel_0_i;
input       alu_sel_1_i;
input       inv_sel_i;
input       shftr_sel_i;
input       shftl_sel_i;

input [7:0]  oprnd_0_i;
input [7:0]  oprnd_1_i;
output [7:0] alu_result_o;

output      cf_o;

wire [7:0] add_result = oprnd_0_i[7:0] + oprnd_1_i[7:0];

wire [7:0] and_result = oprnd_0_i[7:0] & oprnd_1_i[7:0];

wire [7:0] inv_mux_out = inv_sel_i ? oprnd_1_i[7:0] : oprnd_0_i[7:0];

wire [7:0] inv_result = ~inv_mux_out[7:0];

wire [7:0] shftl_mux_out = shftl_sel_i ? oprnd_1_i[7:0] : oprnd_0_i[7:0];

wire [7:0] shftl_result = {shftl_mux_out[6:0], 1'b0};

wire [7:0] alu_0_mux_out = alu_sel_0_i[1:0] == 0 ? and_result[7:0] : alu_sel_0_i[1:0] == 1 ? add_result[7:0]
			  : alu_sel_0_i[1:0] == 2 ? inv_result[7:0] : shftl_result[7:0];

wire [7:0] shftr_mux_out = shftr_sel_i ? oprnd_1_i[7:0] : oprnd_0_i[7:0];

wire [7:0] shftr_result = {1'b0, shftr_mux_out[7:1]};

wire [7:0] alu_result_o =  alu_sel_1_i ? shftr_result[7:0] : alu_0_mux_out[7:0];

wire cmpeq_result = oprnd_0_i[7:0] == oprnd_1_i[7:0];

wire cmplt = oprnd_0_i[7:0] < oprnd_1_i[7:0];

wire cf_o =  cf_sel_i ? cmpeq : cmplt;


endmodule
