`include "define.v"

module EXE_MEM_stage (
	
	input  clk,  
//	input [`DSIZE-1:0] rdata1_in,
	input [`DSIZE-1:0]aluout_in,
	input [`DSIZE-1:0] rdata2_in,
	input [`ASIZE-1:0]waddr_in,
	input wen_in,
	input memread_in,
	input memwrite_in,
	input memtoreg_in,
   input jal_in,
	input [`ISIZE-1:0]PCOUT_in,
	
//	output reg [`DSIZE-1:0] rdata1_out,
	output reg [`DSIZE-1:0]aluout_out,
	output reg [`DSIZE-1:0] rdata2_out,
	output reg [`ASIZE-1:0]waddr_out,
	output reg wen_out,
	output reg memread_out,
	output reg memwrite_out,
	output reg memtoreg_out,
	output reg jal_out,
	output reg [`ISIZE-1:0]PCOUT_out
);



//here we have not taken write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.
always @ (posedge clk) begin
	
		 begin
		 
//		 rdata1_out <= rdata1_in;
		 aluout_out  <= aluout_in;
		 rdata2_out <= rdata2_in;
		 waddr_out  <= waddr_in;
		 wen_out    <= wen_in;
		 memread_out <= memread_in;
		 memwrite_out <= memwrite_in;
	    memtoreg_out <= memtoreg_in;
       jal_out<=jal_in;		 
		 PCOUT_out<=PCOUT_in;
		 
	end
 
end
endmodule


