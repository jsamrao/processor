/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: euc.v
# Design: Execution Unit Controller
# Description: Implements the controller (state machine) for the execution unit.
#              All controls for the execution unit data path are generated here.
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/

module euc (clk, rst, data_mem_rd_enb_o,  data_mem_wr_enb_o,  wr_data_sel_o,  r0_const_sel_o,  r1_const_sel_o,  cf_sel_o,  cmp_flag_sel_o,  alu_sel_0_o,  alu_sel_1_o,  inv_sel_o,  shftr_sel_o,  shftl_sel_o,  r0_sel_o,  r1_sel_o, src_reg_i, dst_reg_i, 
id_ld_i, id_and_i, id_str_i, id_add_i, id_addi_i, id_cmplt_i, id_cmpeq_i, id_cmpeqi_i, id_shftr_i, id_shftl_i, id_inv_i, id_mvi_i, instr_valid_i, instr_done_o);

input clk;
input rst;

// Inputs and outputs from/to instruction fetch unit for state machine
input instr_valid_i
output instr_done_o;

// Inputs from instruction decoder for state machine
input id_ld_i;
input id_and_i;
input id_str_i;
input id_add_i;
input id_addi_i;
input id_cmplt_i;
input id_cmpeq_i;
input id_cmpeqi_i;
input id_shftr_i;
input id_shftl_i;
input id_inv_i;
input id_mvi_i;

input src_reg_i;
input dst_reg_i;

// Outputs to execution unit data path (including alu)
output       data_mem_rd_enb_o;
output       data_mem_wr_enb_o;
output       wr_data_sel_o;
output       r0_const_sel_o;
output       r1_const_sel_o;
output       cf_sel_o;
output       cmp_flag_sel_o;
output       alu_sel_1_o;
output       inv_sel_o;
output       shftr_sel_o;
output       shftl_sel_o;
output [1:0] alu_sel_0_o;
output [1:0] r0_sel_o;
output [1:0] r1_sel_o;


// States
parameter LOAD	= 4'd0;
parameter AND   = 4'd1;
parameter STORE	= 4'd2;
parameter ADD   = 4'd3;
parameter ADI   = 4'd4;
parameter CMPLT = 4'd5;
parameter CMPEQ = 4'd6;
parameter CMPEQI = 4'd7;
parameter SHFTR = 4'd8;
parameter SHFTL = 4'd9;
parameter INV   = 4'd10;
parameter MVI   = 4'd11;
parameter IDLE	= 4'd15;


wire [3:0] euc_ns, euc_cs;
wire       idle_and_instr_valid = (euc_cs[3:0] == IDLE) & instr_valid_i;
wire       not_idle = (euc_cs[3:0] != 4'd15);

assign euc_ns[0] = (idle_and_instr_valid & (id_and_i || id_add_i || id_cmplt_i || id_cmpeqi_i || id_shftl_i || id_mvi_i)) || not_idle;
assign euc_ns[1] = (idle_and_instr_valid & (id_str_i || id_add_i || id_cmpeq_i || id_cmpeqi_i || id_inv_i || id_mvi_i)) || not_idle;
assign euc_ns[2] = (idle_and_instr_valid & (id_adi_i || id_cmplt_i || id_cmpeq_i || id_cmpeqi_i)) || not_idle;
assign euc_ns[3] = (idle_and_instr_valid & (id_shftr_i || id_shftl_i || id_inv_i || id_mvi_i)) || not_idle;
	
	
dff euc_sm_ff0 (euc_cs[0], euc_ns[0], clk, rst);
dff euc_sm_ff1 (euc_cs[1], euc_ns[1], clk, rst);
dff euc_sm_ff2 (euc_cs[2], euc_ns[2], clk, rst);
dff euc_sm_ff3 (euc_cs[3], euc_ns[3], clk, rst);


// Generate outputs

assign data_mem_rd_enb_o = (euc_cs == LOAD);
assign data_mem_wr_enb_o = (euc_cs == STORE);
assign wr_data_sel_o = (euc_cs == STORE & src_reg_i == 1);
assign r0_const_sel_o = (euc_cs == ADI || euc_cs == CMPEQI) & (src_reg_i == 1); 
assign r1_const_sel_o = (euc_cs == ADI || euc_cs == CMPEQI) & (src_reg_i == 0); 
assign cf_sel_o = (euc_cs == CMPEQ || euc_cs == CMPEQI);
assign cmp_flag_sel_o = (euc_cs == CMPEQ || euc_cs == CMPEQI || euc_cs == CMPLT);
assign alu_sel_0_o = (euc_cs == ADD || euc_cs == ADI) ? 2'd1 : (euc_cs == INV) ? 2'd2 : (euc_cs == SHFTL) ? 2'd3 : 2'd0;
assign inv_sel_o = src_reg_i;
assign shftr_sel_o = src_reg_i;
assign shftl_sel_o = src_reg_i;
assign alu_sel_1_o = (euc_cs == SHFTR);

assign r0_sel_o = ((euc_cs == AND || euc_cs == ADI || euc_cs == SHFTR || euc_cs == SHFTL || euc_cs == INV) & (dst_reg_i == 0)) ? 2'd1 : 
	           (euc_cs == MVI & dst_reg_i == 0) ? 2'd2 : (euc_cs == LOAD & dst_reg_i == 0) ? 2'd3 : 2'd0;
	
assign r1_sel_o = ((euc_cs == AND || euc_cs == ADI || euc_cs == SHFTR || euc_cs == SHFTL || euc_cs == INV) & (dst_reg_i == 1)) ? 2'd1 : 
	           (euc_cs == MVI & dst_reg_i == 1) ? 2'd2 : (euc_cs == LOAD & dst_reg_i == 1) ? 2'd3 : 2'd0;

assign instr_done_o = euc_cs[3:0] != 4'd15;

endmodule
