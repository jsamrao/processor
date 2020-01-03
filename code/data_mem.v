/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: data_mem.v
# Design: Data Memory
# Description: 256 x 8b memory.
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/

module data_mem (clk, rst, data_mem_rd_enb_i, data_mem_wr_enb_i, data_mem_addr_i, 
	         data_mem_wr_data_i, data_mem_rd_data_o);

input clk;
input rst;

input       data_mem_rd_enb_i;
input       data_mem_wr_enb_i;
input [7:0] data_mem_addr_i;
input [7:0] data_mem_wr_data_i;
output  [7:0] data_mem_rd_data_o;


integer i;
reg [7:0] data_mem[0:255];

always @ (posedge clk or negedge rst) begin
  if (~rst) begin
     for (i = 0; i < 256; i = i + 1) begin
	data_mem[i] <= 0; 
     end
  end else begin
     if (data_mem_wr_enb_i) begin
	data_mem[data_mem_addr_i] <= data_mem_wr_data_i; 
     end
  end
end

assign data_mem_rd_data_o = data_mem_rd_enb_i ? data_mem[data_mem_addr_i] : 8'd0;

endmodule
