
module alu(input logic [31:0] a, b,
		   input logic [4:0] shamt,
           input logic [4:0] alucontrol,
           output logic [31:0] aluout,
           output logic zeroflag);

	always_comb
		case (alucontrol)//alucontrol[3:0]
			5'b00010: aluout = a + b; //ADD
			5'b00110: aluout = a - b; //SUB
			5'b00000: aluout = a & b; //AND
			5'b00001: aluout = a | b; //OR
          	5'b00111: aluout = ( a < b ) ? 32'b1 : 32'b0;//SLT
			//my impl. start
			5'b00101: aluout = a ^ b; //XOR
			5'b01110: aluout = ( b << shamt); //SLL: rd <- (rt << sa)
			5'b01000: aluout = ( b >> shamt ); //SRL: rd <- (rt >> sa) (logical)
			5'b11001: aluout = $signed(b) >>> shamt; //SRA: rd <- (rt >> sa) (arithmetic)

			5'b00011: aluout = b << 16; //LUI: imm << 16bit
			//my impl. end
			default: aluout = 0;
		endcase

    assign zeroflag = (aluout==0) ? 32'b1 : 32'b0;

endmodule

/*
module alu(input  logic [31:0] a, b,
           input  logic [2:0]  alucontrol,
           output logic [31:0] result,
           output logic        zero);

  logic [31:0] condinvb, sum;

  assign condinvb = alucontrol[2] ? ~b : b;
  assign sum = a + condinvb + alucontrol[2];

  always_comb
    case (alucontrol[1:0])
      2'b00: result = a & b;
      2'b01: result = a | b;
      2'b10: result = sum;
      2'b11: result = sum[31];
    endcase

  assign zero = (result == 32'b0);
endmodule
*/

/*
20020005
2003000c
2067fff7
00e22025
00642824
00a42820
10a7000a
0064202a
10800001
20050000
00e2202a
00853820
00e23822
ac670044
8c020050
08000011
20020001
ac020054

*/