`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:58:53 11/07/2014
// Design Name:   pipelined_regfile_2stage
// Module Name:   D:/Study/3.1/CE3001/3001_project/CZ3001_project/testbench_4stqg.v
// Project Name:  CZ3001_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipelined_regfile_2stage
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_4stqg;

	// Inputs
	reg clk;
	reg rst;
	reg fileid;

	// Outputs
	wire [15:0] PCOUT;
	wire [15:0] INST;
	wire [3:0] aluop;
	wire [15:0] aluout;
	wire [15:0] rdata1;
	wire [15:0] rdata2;
	wire regdst;
	wire alusrc;
	wire [15:0] s_ext;
	wire Branch;
	wire memtoreg;
	wire jr;
	wire jump;
	wire [15:0] data_out_MEM_WB;
   wire PCsrc;
	wire [15:0] wdata;

	// Instantiate the Unit Under Test (UUT)
	pipelined_regfile_2stage uut (
		.clk(clk), 
		.rst(rst), 
		.fileid(fileid), 
		.PCOUT(PCOUT), 
		.INST(INST), 
		.aluop(aluop), 
		.aluout(aluout), 
		.rdata1(rdata1), 
		.rdata2(rdata2), 
		.regdst(regdst), 
		.alusrc(alusrc), 
		.s_ext(s_ext), 
		.Branch(Branch), 
		.memtoreg(memtoreg),
		.jump(jump),
		.jr(jr),
	   .data_out_MEM_WB(data_out_MEM_WB),
		.PCsrc(PCsrc),
		.wdata(wdata)
	);
	
 
always #15 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		fileid = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
#25 rst =1;
#25 rst=0;


	end
      
endmodule

