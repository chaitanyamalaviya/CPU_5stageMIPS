

`timescale 1ns / 1ps
`include "define.v"

module pipelined_regfile_2stage(clk, rst,  fileid, PCOUT, INST, aluop, aluout, rdata1, rdata2, regdst,alusrc, s_ext, Branch, memtoreg, jr, jump,  PCsrc, data_out_MEM_WB,wdata);

input clk;                
                                            
input rst;
input fileid;

output [`DSIZE-1:0] s_ext ;
output [`ISIZE-1:0]PCOUT;
output [`DSIZE-1:0] rdata1;
output [`DSIZE-1:0] rdata2;
output [`DSIZE-1:0] aluout;
output [`DSIZE-1:0]INST;
output [3:0] aluop;
output Branch;
output regdst;
output alusrc;
output memtoreg;
output jump;
output jr;
wire jal;
output PCsrc;

wire [3:0] raddr2; 
wire zero;                               

wire [15:0] data_out ;//Output of data memory     
wire [`ISIZE-1:0]PCIN;
wire memwrite;
wire memread;

wire [`DSIZE-1:0]MemToRegRes;
wire [`ASIZE-1:0]waddr;
output [`DSIZE-1:0]wdata;

////////  Outputs from ID_EXE pipeline  //////////////
wire [3:0] aluop_ID_EXE;
wire Branch_ID_EXE;
wire [`ISIZE-1:0]PCOUT_ID_EXE;
wire [`DSIZE-1:0]s_ext_ID_EXE;
wire [`DSIZE-1:0]rdata1_ID_EXE;
wire [`DSIZE-1:0]b_ID_EXE;
wire [`DSIZE-1:0]rdata2_ID_EXE;
wire [`ASIZE-1:0]waddr_ID_EXE;
wire wen_ID_EXE;
wire memread_ID_EXE;
wire memwrite_ID_EXE;
wire memtoreg_ID_EXE;
wire jal_ID_EXE;

////////  Outputs from EXE_MEM pipeline  //////////////
wire [`DSIZE-1:0] aluout_EXE_MEM;
wire [`ISIZE-1:0]PCOUT_EXE_MEM;
wire [`DSIZE-1:0]rdata2_EXE_MEM;
wire [`ASIZE-1:0]waddr_EXE_MEM;
wire wen_EXE_MEM;
wire memread_EXE_MEM;
wire memwrite_EXE_MEM;
wire memtoreg_EXE_MEM;
wire jal_EXE_MEM;


////////  Outputs from MEM_WB pipeline  //////////////
output [`DSIZE-1:0]data_out_MEM_WB;
wire [`DSIZE-1:0]aluout_MEM_WB;
wire [`ISIZE-1:0]PCOUT_MEM_WB;
wire [`ASIZE-1:0]waddr_MEM_WB;
wire wen_MEM_WB;
wire memtoreg_MEM_WB;

reg [`ISIZE-1:0]PCIN1;
wire jal_MEM_WB;

PC1 pc(.clk(clk),.rst(rst),.nextPC(PCIN),.currPC(PCOUT));


//////////////////////  increment PC   ////////////////////////
always @((clk))
begin
if(PCsrc ==0)
PCIN1 <= PCOUT + 16'b1; //increments PC to PC +1
else 
PCIN1 <= PCOUT_ID_EXE + s_ext; //If PCsrc is 1 ie branch condition is satisfied, PC increments by immediate value
end
////////////////////////////////////////////////////////////////



memory im( .clk(clk), .rst(rst), .wen(1'b0), .addr(PCOUT), .data_in(16'b0), .fileid(4'b0),.data_out(INST));

//wire wen;  //This wire controls data memory

//wire [15:0] wdata; //Wire for write data can either be alu output or output of data memory
 
control C0 (.rst(rst),.inst(INST[15:12]),.wen(wen), .aluop(aluop),.regdst(regdst),.alusrc(alusrc),.memtoreg(memtoreg),.memread(memread),.memwrite(memwrite),.Branch(Branch),.jump(jump),.jal(jal),.jr(jr));

assign raddr2 = (regdst) ? INST[11:8] : INST[3:0] ;  //Assiging raddr2

regfile  RF0 ( .clk(clk), .rst(rst), .wen(wen_MEM_WB), .raddr1(INST[7:4]), .raddr2(raddr2), .waddr(waddr), .wdata(wdata), .rdata1(rdata1), .rdata2(rdata2));

sign_extend S (.in(INST[3:0]), .out(s_ext));

wire [`DSIZE-1:0]b;
assign b = (alusrc) ? s_ext : rdata2; 

ID_EXE_stage PIPE1 (.clk(clk),.rst(rst),.aluop_in(aluop),.Branch_in(Branch),.PCOUT_in(PCOUT),.s_ext_in(s_ext),.jal_in(jal),.rdata1_in(rdata1),.b_in(b),.rdata2_in(rdata2),.waddr_in(INST[11:8]),.wen_in(wen),.memwrite_in(memwrite),.memread_in(memread),.memtoreg_in(memtoreg),.aluop_out(aluop_ID_EXE),.Branch_out(Branch_ID_EXE),.PCOUT_out(PCOUT_ID_EXE),.s_ext_out(s_ext_ID_EXE),.rdata1_out(rdata1_ID_EXE),.b_out(b_ID_EXE),.rdata2_out(rdata2_ID_EXE),.waddr_out(waddr_ID_EXE),.wen_out(wen_ID_EXE),.memwrite_out(memwrite_ID_EXE),.memread_out(memread_ID_EXE),.memtoreg_out(memtoreg_ID_EXE),.jal_out(jal_ID_EXE));

alu ALU0 ( .a(rdata1_ID_EXE), .b(b_ID_EXE), .op(aluop_ID_EXE), .imm(s_ext_ID_EXE), .out(aluout),.zero(zero));

EXE_MEM_stage PIPE2 (.clk(clk),.aluout_in(aluout),.rdata2_in(rdata2_ID_EXE),.PCOUT_in(PCOUT_ID_EXE),.jal_in(jal_ID_EXE),.waddr_in(waddr_ID_EXE),.wen_in(wen_ID_EXE),.memread_in(memread_ID_EXE),.memwrite_in(memwrite_ID_EXE),.memtoreg_in(memtoreg_ID_EXE),.aluout_out(aluout_EXE_MEM),.rdata2_out(rdata2_EXE_MEM),.PCOUT_out(PCOUT_EXE_MEM),.waddr_out(waddr_EXE_MEM),.wen_out(wen_EXE_MEM),.memread_out(memread_EXE_MEM),.memwrite_out(memwrite_EXE_MEM),.memtoreg_out(memtoreg_EXE_MEM),.jal_out(jal_EXE_MEM));

data_mem data(.clk(clk), .rst(rst), .addr(aluout_EXE_MEM), .data_in(rdata2_EXE_MEM), .data_out(data_out), .memread(memread_EXE_MEM),.memwrite(memwrite_EXE_MEM));

assign MemToRegRes = (memtoreg_MEM_WB) ? aluout_MEM_WB : data_out_MEM_WB;

assign PCsrc = Branch_ID_EXE & zero;

MEM_WBstage PIPE3 (.clk(clk),.data_out_in(data_out),.aluout_in(aluout_EXE_MEM),.PCOUT_in(PCOUT_EXE_MEM),.jal_in(jal_EXE_MEM),.waddr_in(waddr_EXE_MEM),.wen_in(wen_EXE_MEM),.memtoreg_in(memtoreg_EXE_MEM),.data_out_out(data_out_MEM_WB),.aluout_out(aluout_MEM_WB),.waddr_out(waddr_MEM_WB),.wen_out(wen_MEM_WB),.memtoreg_out(memtoreg_MEM_WB), .jal_out(jal_MEM_WB),.PCOUT_out(PCOUT_MEM_WB));

wire [`ISIZE-1:0]jumpres;

//assign PCIN1 = PCsrc ? PCOUT_ID_EXE + s_ext : PCOUT + 16'b1; 
//assign PCIN1 = PCOUT + 16'b1;
 
assign jumpres = jump ? {PCOUT[15:12],INST[11:0]} : PCIN1;
//assign jumpres = PCIN1;

assign PCIN = jr ? rdata1 : jumpres;
//assign PCIN = jumpres;

assign wdata = jal_MEM_WB ? PCOUT_MEM_WB : MemToRegRes;

assign waddr = jal_MEM_WB ? 4'b1111 : waddr_MEM_WB; 

endmodule