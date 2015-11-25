`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Created by:  Mao Huiqi
// Create Date:    23:41:01 11/01/2014 
// Design Name: 
// Module Name:    MEM_WBstage 
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MEM_WBstage(
    input [`DSIZE-1:0]data_out_in,
    input [`DSIZE-1:0]aluout_in,
    input [`ASIZE-1:0]waddr_in,
    input wen_in,
    input memtoreg_in,
	 input clk,
	 input jal_in,
	 input [`ISIZE-1:0]PCOUT_in,
	 
    output reg [`DSIZE-1:0]data_out_out,
    output reg [`DSIZE-1:0]aluout_out,
    output reg [`ASIZE-1:0]waddr_out,
    output reg wen_out,
    output reg memtoreg_out,
	 output reg jal_out,
	 output reg [`ISIZE-1:0]PCOUT_out
    );

always @ (posedge clk) 
	
		 begin
		 
		 data_out_out <=  data_out_in;
		 aluout_out   <=  aluout_in;
		 waddr_out    <=  waddr_in;
		 wen_out      <=  wen_in;
		 memtoreg_out <=  memtoreg_in;
		 jal_out <= jal_in;
		 PCOUT_out <= PCOUT_in;
	    end

endmodule
