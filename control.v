//control unit for write enable and ALU control

`include "define.v"
module control(
  input rst,
  input [3:0] inst,
  output reg wen,
  output reg memread,
  output reg memwrite,
  output reg Branch,
  output reg alusrc,
  output reg memtoreg,
  output reg [3:0] aluop,
  output reg jr,
  output reg jump,
  output reg jal,
  output reg regdst
  );
  
  always@(*)
  begin

  if(rst)
	begin
		  jal = 1'b0;
		  jump = 1'b0;
		  jr = 1'b0;
		  regdst = 1'b0;
	end
	
   else
	begin
    case(inst)
    `ADD: begin
        wen=1'b1;
        aluop=inst;
		  alusrc=1'b0;
        memtoreg=1'b1;   
		  memread= 1'b0;
		  memwrite = 1'b0;
		  Branch=1'b0;
		  jal = 1'b0;
		  jump = 1'b0;
		  jr = 1'b0;
      end
	  `SUB: begin
        wen=1'b1;
		  aluop=inst;
		  alusrc=1'b0;
		  memtoreg=1'b1;
		  memread= 1'b0;
		  memwrite = 1'b0;
		  Branch=1'b0;
		  jal = 1'b0;
		  jump = 1'b0;
		  jr = 1'b0;
	  end
     `AND: begin
			 wen=1'b1;
			 aluop=inst;
			 alusrc=1'b0;
			 memtoreg=1'b1;
			 memread= 1'b0;
			 memwrite = 1'b0;
			 Branch=1'b0;
			 jal = 1'b0;
		    jump = 1'b0;
		    jr = 1'b0;
        end
        `XOR: begin
          wen=1'b1;
          aluop=inst;
			 alusrc=1'b0;
			 memtoreg=1'b1;
			 memread= 1'b0;
			 memwrite = 1'b0;
			 Branch=1'b0;
			 jal = 1'b0;
		    jump = 1'b0;
		    jr = 1'b0;
        end
        `SLL: begin
          wen=1'b1;
          aluop=inst;
          alusrc=1'b1;
          memtoreg=1'b1;
          memread= 1'b0;
			 memwrite = 1'b0;
          Branch=1'b0;     
			 jal = 1'b0;
		    jump = 1'b0;
		    jr = 1'b0;			 
        end
        `SRL: begin
          wen=1'b1;
          aluop=inst;
          alusrc=1'b1;
          memtoreg=1'b1;
          memread= 1'b0;
			 memwrite = 1'b0;
			 Branch=1'b0;
			 jal = 1'b0;
		    jump = 1'b0;
		    jr = 1'b0;
        end
        `COM: begin
          wen=1'b1;
          aluop=inst;
          alusrc=1'b0;
          memtoreg=1'b1;
          memread= 1'b0;
			 memwrite = 1'b0;
			 Branch=1'b0;
			 jal = 1'b0;
		    jump = 1'b0;
		    jr = 1'b0;
        end
        `MUL: begin
          wen=1'b1;
          aluop=inst;
          alusrc=1'b0;
          memtoreg=1'b1;
          memread= 1'b0;
			 memwrite = 1'b0;
          Branch=1'b0;
			 jal = 1'b0;
		    jump = 1'b0;
	    	 jr = 1'b0;
        end
          `LW: begin
                  wen=1'b1;
                     aluop = inst;
                     alusrc=1'b1;
                     memtoreg=1'b0;
                     memread= 1'b1;
						   memwrite = 1'b0;
							Branch=1'b0;
							jal = 1'b0;
		               jump = 1'b0;
		               jr = 1'b0;
          end
          `SW: begin
                wen=1'b0;
                  aluop = inst;
                  alusrc=1'b1;
                  memtoreg=1'b1;
                  memread= 1'b0;
						memwrite = 1'b1;
						Branch=1'b0;
						jal = 1'b0;
		  jump = 1'b0;
		  jr = 1'b0;
		  regdst = 1'b1;
          end
          `BEQ: begin
                wen = 1'b0;
                  aluop = inst;
                  alusrc=1'b0;
                  memtoreg=1'b1;
                  Branch=1'b1;
                  memread= 1'b0;
						memwrite = 1'b0;
						jal = 1'b0;
		            jump = 1'b0;
		            jr = 1'b0;
						regdst = 1'b1;
          end
			 
		    `J: begin
			 wen = 1'b0;
          aluop = inst;
          alusrc=1'b0;
          memtoreg=1'b1;
          Branch=1'b1;
          memread= 1'b0;
			 memwrite = 1'b0;
			 jal = 1'b0;
		    jump = 1'b1;
		    jr = 1'b0;
          end
			 
			 `JR: begin 
			 wen = 1'b0;
			 aluop = inst;
			 alusrc=1'b0;
			 memtoreg=1'b1;
			 Branch=1'b1;
			 memread= 1'b0;
			 memwrite = 1'b0;
			 jal = 1'b0;
		    jump = 1'b0;
		    jr = 1'b1;
          end
			 
			 `JAL: begin
			 wen = 1'b0;
			 aluop = inst;
			 alusrc=1'b0;
			 memtoreg=1'b1;
			 Branch=1'b1;
			 memread= 1'b0;
			 memwrite = 1'b0;
			 jal = 1'b1;
		    jump = 1'b0;
		    jr = 1'b0;
          end
    endcase
	 end
  end
  
endmodule
