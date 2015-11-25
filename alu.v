`include "define.v"// defines


module alu(
   a,   //1st operand
   b,   //2nd operand
   op,   //4-bit operation
   imm,   //4-bit immediate operand for shift/rotate
   out,
   zero   //output
   );


   
   input [`DSIZE-1:0] a, b;
   input [3:0] op;
   input [`DSIZE-1:0] imm;
   output [`DSIZE-1:0] out;
   output reg zero;

	reg [`DSIZE-1:0] out; 
      
always @(a or b or op or imm)
begin
   case(op)
       `ADD: out = a+b;
       `SUB: out = a - b;
       `AND: out = a & b;
       `XOR:  out = a^b;
       `SLL: out = a << imm;
       `SRL: out = a >> imm;
       `COM: out = a<=b;
       `MUL: out = a*b;
		 `LW: out = b;
		 `SW: out = b;
		 `BEQ:  begin
		        if (a==b)
				   zero = 1;
				  else
				   zero = 0;
       end

   endcase
end

endmodule
   
       
