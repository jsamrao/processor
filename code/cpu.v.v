/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: cpu.v
# Design: CPU includes the processor, data memory, clock and reset 
#         generation logic, and some debug hooks.
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/
`timescale 1ns/100ps

`include "./processor.v"
`include "./data_mem.v"
`include "./Mux2-1.v"
`include "./Mux4-1.v"
`include "./reg_8b.v"

module cpu ();

processor processor (clock, reset, data_mem_rd_enb,  data_mem_wr_enb, data_mem_addr, 
	             data_mem_wr_data, data_mem_rd_data, fetch_enable);

data_mem data_mem (clock, reset, data_mem_rd_enb, data_mem_wr_enb, data_mem_addr, 
	         data_mem_wr_data, data_mem_rd_data);

reg clock, reset, fetch_enable;

// Clock generator
initial begin
   clock = 0;
   forever #1 clock = ~clock;
end

initial begin
  fetch_enable = 0;
  reset = 1;
  @ (posedge clock);
  reset = 0;
  @ (posedge clock);
  reset = 1;
  
  //while (1) begin
     @ (posedge clock);
     @ (posedge clock);
     @ (posedge clock);
     @ (posedge clock);
     fetch_enable = 1;

     @ (posedge clock);
     fetch_enable = 0;
  //end
end

initial begin
  $fsdbDumpfile("cpu.fsdb");
  $fsdbDumpvars;
end

endmodule
