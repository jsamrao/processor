/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: processor.v
# Design: Processor includes instruction fetch, decode, and execution units.
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/
`timescale 1ns/100ps

`include "./ifu.v"
`include "./idu.v"
`include "./eudp.v"
`include "./euc.v"

module processor (clk, rst, data_mem_rd_enb_o,  data_mem_wr_enb_o, data_mem_addr_o, data_mem_wr_data_o, data_mem_rd_data_i, fetch_enable_i);

input clk;
input rst;

// Debug
input fetch_enable_i;

// Data Memory
output       data_mem_rd_enb_o;
output       data_mem_wr_enb_o;
output [7:0] data_mem_addr_o;
output [7:0] data_mem_wr_data_o;
input  [7:0] data_mem_rd_data_i;



ifu ifu (clk, fetch_enable_i, instr_valid, instr_done, instr, cmp_flag);

idu idu(clk, instr, id_ld, id_and, id_str, id_add, id_addi, id_cmplt, id_cmpeq, id_cmpeqi, 
	id_shftr, id_shftl, id_inv, id_mvi, imm_addr_const, src_reg, dst_reg);

eudp eudp (clk, rst, euc_data_mem_rd_enb,  euc_data_mem_wr_enb,  wr_data_sel,  r0_const_sel,  
	   r1_const_sel,  cf_sel,  cmp_flag_sel,  alu_sel_0,  alu_sel_1,  inv_sel,  
	   shftr_sel,  shftl_sel,  r0_sel,  r1_sel, data_mem_rd_enb_o, data_mem_wr_enb_o, 
	   data_mem_addr_o, data_mem_wr_data_o, data_mem_rd_data_i, cmp_flag, imm_addr_const);

euc euc (clk, rst, euc_data_mem_rd_enb,  euc_data_mem_wr_enb,  wr_data_sel,  r0_const_sel,  
 	 r1_const_sel,  cf_sel,  cmp_flag_sel,  alu_sel_0,  alu_sel_1,  inv_sel,  
	 shftr_sel,  shftl_sel,  r0_sel,  r1_sel, src_reg, dst_reg, 
         id_ld, id_and, id_str, id_add, id_addi, id_cmplt, id_cmpeq, id_cmpeqi, id_shftr, 
	 id_shftl, id_inv, id_mvi, instr_valid, instr_done);

endmodule
