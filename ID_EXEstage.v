`include "define.v"

module ID_EXE_stage (
	
	input  clk,
   input  rst,	
	input [3:0]aluop_in,
	input Branch_in,
	input [`ISIZE-1:0]PCOUT_in,
	input [`DSIZE-1:0] s_ext_in,
	input [`DSIZE-1:0] rdata1_in,
	input [`DSIZE-1:0]b_in,
	input [`DSIZE-1:0] rdata2_in,
	input [`ASIZE-1:0]waddr_in,
	input wen_in,
	input memread_in,
	input memwrite_in,
	input memtoreg_in,
   input jal_in,

	output reg [3:0] aluop_out,
	output reg Branch_out,
	output reg [`ISIZE-1:0]PCOUT_out,
	output reg [`DSIZE-1:0] s_ext_out,
	output reg [`DSIZE-1:0] rdata1_out,
	output reg [`DSIZE-1:0]b_out,
	output reg [`DSIZE-1:0] rdata2_out,
	output reg [`ASIZE-1:0]waddr_out,
	output reg wen_out,
	output reg memread_out,
	output reg memwrite_out,
	output reg memtoreg_out,
	output reg jal_out
);



//here we have not taken write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.
always @ (posedge clk) begin
	
	if(rst)
		Branch_out <= 0;
		 else
		 begin
		 
		 aluop_out <= aluop_in;
		 Branch_out  <= Branch_in;
		 PCOUT_out <= PCOUT_in;
		 s_ext_out  <= s_ext_in;
		 rdata1_out    <= rdata1_in;
		 b_out <= b_in;
		 rdata2_out <= rdata2_in;
		 waddr_out <= waddr_in;
		 wen_out <= wen_in;
		 memread_out <= memread_in;
		 memwrite_out <= memwrite_in;
	    memtoreg_out <= memtoreg_in;
		 jal_out<=jal_in;

		 
	end
 
end
endmodule


