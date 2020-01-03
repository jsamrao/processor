/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: eudp.v
# Design: Execution Unit Data Path
# Description: Implements the data path for the execution unit, including the
#              register file, ALU, and interface to the data memory.
#              All data path control signals come from execution unit controller.
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/


module eudp (clk, rst, data_mem_rd_enb_i,  data_mem_wr_enb_i,  wr_data_sel_i,  r0_const_sel_i,  r1_const_sel_i,  cf_sel_i,  cmp_flag_sel_i,  alu_sel_0_i,  alu_sel_1_i,  inv_sel_i,  shftr_sel_i,  shftl_sel_i,  r0_sel_i,  r1_sel_i, data_mem_rd_enb_o, data_mem_wr_enb_o, data_mem_addr_o, data_mem_wr_data_o, data_mem_rd_data_i, cmp_flag_o, imm_addr_const_i);

input clk;
input rst;

// Instruction decoder
input [7:0] imm_addr_const_i;

// Controls from execution unit controller (euc.v)
input       data_mem_rd_enb_i;
input       data_mem_wr_enb_i;
input       wr_data_sel_i;
input       r0_const_sel_i;
input       r1_const_sel_i;
input       cf_sel_i;
input       cmp_flag_sel_i;
input [1:0] alu_sel_0_i;
input       alu_sel_1_i;
input       inv_sel_i;
input       shftr_sel_i;
input       shftl_sel_i;
input [1:0] r0_sel_i;
input [1:0] r1_sel_i;

// Data Memory
output       data_mem_rd_enb_o;
output       data_mem_wr_enb_o;
output [7:0] data_mem_addr_o;
output [7:0] data_mem_wr_data_o;
input  [7:0] data_mem_rd_data_i;

// Instruction Fetch Unit
output       cmp_flag_o;





endmodule
