/*###########################################################################
#                             ALL RIGHTS RESERVED
# Owner: Johar S. Samrao
# 
# File: ifu.v
# Design: Instruction Fetch Unit 
# Author: Johar S. Samrao
# Date: 8/12/2019
#
#############################################################################*/

module ifu(clock, fetch_enable_i, instr_valid_o, instr_done_i, instr_o, cf_i);

input         clock;

// For debugging. 
input         fetch_enable_i;

// Execution unit controller
output         instr_valid_o;
input         instr_done_i;

// Execution unit data path
input         cf_i;

// Instruction decode unit
output [15:0] instr_o;

reg [15:0] code_memory [0:255];
reg [8:0]  program_counter;
reg [15:0] instr_o;
reg        instr_valid_o;
integer i;

parameter EOP  = 4'd15;
parameter JMP  = 4'd14;
parameter JMPS = 4'd13;
initial begin

  // initialize code memory to all zeros
  for ( i = 0; i < 255; i = i + 1 ) begin
    code_memory[i] = 0;
  end

  // load code memory from user program
  $display("Loading program into code memory ...");
  $readmemb("program.txt", code_memory, 0, 255);
  $display("Done.");

  // for debug help
  for (i=0; i<255; i=i+1) begin
    $display("Address: ", i, " %b", code_memory[i]);
  end

  program_counter = 0;

  // real instruction fetch work
  while (1) begin
     @ (posedge clock);

     // fetch_enable_i allows single stepping of instruction fetch and execution
     if (fetch_enable_i === 1) begin

        // fetch next instruction
        instr_o = code_memory[program_counter];

	$display ("program counter: %0d", program_counter, "  instr: %4b_%2b_%2b_%8b", instr_o[15:12], instr_o[11:10], instr_o[9:8], instr_o[7:0]);

        // End of program. Finish simulation.
        if (instr_o[15:12] == EOP || program_counter == 256) begin
	   if (instr_o[15:12] == EOP) begin
	      $display ("Reached EOP instruction. Ending program.");
	   end else begin
	      $display ("Reached end of code memory. Ending program.");
	   end
	   repeat (5) @ (posedge clock);
	   $finish;
	end

        // If fetched instruction is jump, need to jump and get the next instruction.
	// A jump instruction can jump to another jump instruction.
	while (instr_o[15:12] == JMP || (instr_o[15:12] == JMPS && cf_i)) begin
	   program_counter = instr_o[7:0]; // set program counter to jump address
           instr_o = code_memory[program_counter]; // get the instruction from jump address
	   $display ("program counter: %0d", program_counter, "  instr: %4b_%2b_%2b_%8b", instr_o[15:12], instr_o[11:10], instr_o[9:8], instr_o[7:0]);
	end
        
	// point program counter to next instruction
	program_counter = program_counter + 1;

        // set instruciton valid to execution unit controller
	instr_valid_o = 1;

        // wait for instruction done from execution unit controller
	@ (posedge clock);
	wait (instr_done_i);

     end // if fetch enabled
  end // while 1

end // initial
endmodule

