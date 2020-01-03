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


module eudp (clk, rst, data_mem_rd_enb_i,  data_mem_wr_enb_i,  wr_data_sel_i,  r0_const_sel_i,  r1_const_sel_i,  cf_sel_i,  cmp_flag_sel_i,  alu_sel_0_i,  alu_sel_1_i,  inv_sel_i,  shftr_sel_i,  shftl_sel_i,  r0_sel_i,  r1_sel_i, data_mem_rd_enb_o, data_mem_wr_enb_o, data_mem_addr_o, data_mem_wr_data_o, data_mem_rd_data_i, cmp_flag_o);

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

//Init Wires
wire data_mem_r0, data_mem_r1, r0_d, r0,q, r1_d, r1_q, oprnd_0_i, oprnd_1_i, cf;

//R0
Mux4to1_8b r0_Mux(data_mem_rd_data_i, imm_addr_cost_i , alu_result , r0_q, r0_sel_i, r0_d);

reg_8b r0(clk, rst, r0_d, r0_q);

Mux2to1_8b r0_const_mux (imm_addr_const_i, r0_q, r0_const_sel_i, oprnd_0_i);


//R1
Mux4to1_8b r1_Mux(data_mem_rd_data_i, imm_addr_cost_i , alu_result , r1_q, r1_sel_i, r1_d);

reg_8b r1(clk, rst, r1_d, r1_q);

Mux2to1_8b r1_const_mux (imm_addr_const_i, r1_q, r1_const_sel_i, oprnd_1_i);


//ALU
alu (cf_sel_i,  alu_sel_0_i,  alu_sel_1_i,  inv_sel_i,  shftr_sel_i,  shftl_sel_i, oprnd_0_i, oprnd_1_i, alu_result, cf);

//FLAG
Mux2to1_8b flag_mux(cf, cmp_flag_o, cmp_flag_sel_i, cmp_flag_o);

reg_8b flag_ff(clk, rst, cmp_flag_o, cmp_flag_o);

//DATA MEM

Mux2to1_8b wr_data_mux(r0_q, r1_q, wr_data_sel_i, data_mem_wr_data_o);

data_mem data_memory(clk, rst, data_mem_rd_enb_i, data_mem_wr_enb_i, data_mem_addr_i, data_mem_wr_data_i, data_mem_rd_data_o);



endmodule
