//RType
// |op|rs|rt|rd|shamt|funct|
//IType
// |op|rs|rt|imm16|
//JTYPE
// |op|jta26|
/*
module aludec(input  logic [5:0] funct,
              input  logic [3:0] aluop,
              output logic [3:0] alucontrol);

  always_comb
    case(aluop)//default rtype (2'b10) //TODO: can use op directly 6'b100011 for alucontrol<=3'b010 
      4'b0000: alucontrol <= 4'b0010;  // add (for lw/sw/addi)
      4'b0001: alucontrol <= 4'b0110;  // sub (for beq)
      4'b0011: alucontrol <= 4'b0001;  // or (for ori)
      4'b0100: alucontrol <= 4'b1100;  //lui  (for lui)
      default: case(funct)          // R-type instructions
          6'b100000: alucontrol <= 4'b0010; // add
          6'b100010: alucontrol <= 4'b0110; // sub
          6'b100100: alucontrol <= 4'b0000; // and
          6'b100101: alucontrol <= 4'b0001; // or
          //my impl start.
          6'b100110: alucontrol <= 4'b1000;//xor
          6'b000000: alucontrol <= 4'b1001;//sll
          6'b000010: alucontrol <= 4'b1010;//srl
          6'b000011: alucontrol <= 4'b1011;//sra
          //6'b000010: alucontrol <= 3'b011;//jr Rtype
          //my impl end.
          6'b101010: alucontrol <= 4'b0111; // slt
          default:   alucontrol <= 4'bxxxx; // ???
        endcase
    endcase
endmodule
*/

module aludec(input  logic [5:0] funct,
              input  logic [3:0] aluop,
              output logic [4:0] alucontrol);

  always_comb
    case(aluop)
      4'b0000: alucontrol <= 5'b00010;  // add (for lw/sw/addi)
      4'b0001: alucontrol <= 5'b00110;  // sub (for beq/bne)
      //4'b0010 //default rtype (2'b10) //TODO: can use op directly 6'b100011 for alucontrol<=3'b010 
      4'b0011: alucontrol <= 5'b00011;  //lui  (for lui)
      4'b0100: alucontrol <= 5'b00001;  //or (for ori)
      4'b0101: alucontrol <= 5'b00000; //and (for andi)
      4'b0111: alucontrol <= 5'b00101;//xor (for xori)
      4'b1000: alucontrol <= 5'bxxxxx;//jr
      default: case(funct)          // R-type instructions
          6'b100000: alucontrol <= 5'b00010; // add
          6'b100010: alucontrol <= 5'b00110; // sub
          6'b100100: alucontrol <= 5'b00000; // and
          6'b100101: alucontrol <= 5'b00001; // or
          6'b101010: alucontrol <= 5'b00111; // slt

          6'b100110: alucontrol <= 5'b00101;//xor
          6'b000000: alucontrol <= 5'b01110;//sll
          6'b000010: alucontrol <= 5'b01000;//srl
          6'b000011: alucontrol <= 5'b11001;//sra
          //6'b001000: alucontrol <= 5'b11100;//jr
          default:   alucontrol <= 5'bxxxxx; // ???
        endcase
    endcase
endmodule