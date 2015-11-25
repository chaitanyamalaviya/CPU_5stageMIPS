`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:20:19 10/20/2014 
// Design Name: 
// Module Name:    data_mem 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "define.v"
module data_mem(clk, rst, addr, memread, memwrite, data_in, data_out
    );
input clk;
input memread;
input memwrite;
input rst;
input [15:0] data_in;
input [15:0] addr;
output reg [15:0] data_out;

reg [15:0] memory [ 0:4096*`DSIZE-1];


//always @(posedge clk) begin
//if (memwrite)
 // memory[addr] <= data_in;
//if (memread)
//  data_out <= memory[addr];
//end
always @(*)
begin
  if(memwrite)
    memory[addr] = data_in;
if(memread)
    data_out = memory[addr];
end




endmodule
