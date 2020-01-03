/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: idu.v
# Design: Instruction Decode Unit 
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/

module idu(clock, instr_i, id_ld_o, id_and_o, id_str_o, id_add_o, id_addi_o, id_cmplt_o, id_cmpeq_o, id_cmpeqi_o, id_shftr_o, id_shftl_o, id_inv_o, id_mvi_o, imm_addr_const_o, src_reg_o, dst_reg_o);

input         clock;

// Instruction fetch unit
input [15:0] instr_i;

// Execution unit controller
output id_ld_o;
output id_and_o;
output id_str_o;
output id_add_o;
output id_addi_o;
output id_cmplt_o;
output id_cmpeq_o;
output id_cmpeqi_o;
output id_shftr_o;
output id_shftl_o;
output id_onv_o;
output id_mvi_o;
output src_reg_o;
output dst_reg_o;

// Execution unit data path
output [7:0] imm_addr_const_o;


endmodule
