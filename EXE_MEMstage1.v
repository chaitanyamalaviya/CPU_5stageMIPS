`include "define.v"

module EXE_MEM_stage (
	
	input  clk,  
	input [`DSIZE-1:0] rdata1_in,
	input [`DSIZE-1:0]aluout_in;
	input [`DSIZE-1:0] rdata2_in,
	input [`ASIZE-1:0]waddr_in;
	input wen_in;
	input MemWrite_in;
	input memtoreg_in;

	output reg [`DSIZE-1:0] rdata1_out,
	output reg [`DSIZE-1:0]aluout_out;
	output reg [`DSIZE-1:0] rdata2_out,
	output reg [`ASIZE-1:0]waddr_out;
	output reg wen_out;
	output reg MemWrite_out;
	output reg memtoreg_out;
);



//here we have not taken write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.
always @ (posedge clk) begin
	
		 begin
		 
		 rdata1_out <= rdata1_in,
		 aluout_out  <= aluout_in;
		 rdata2_out <= rdata2_in,
		 waddr_out  <= waddr_in;
		 wen_out    <= wen_in;
		 MemWrite_out <= MemWrite_in;
	    memtoreg_out <= memtoreg_in;

		 
	end
 
end
endmodule


