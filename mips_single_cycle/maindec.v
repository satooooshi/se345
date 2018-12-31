//RType
// |op|rs|rt|rd|shamt|funct|
//IType
// |op|rs|rt|imm16|
//JTYPE
// |op|jta26|
/*
module maindec(input  logic [5:0] op,
               output logic       memtoreg, memwrite,
               output logic       branch, alusrc,
               output logic       regdst, regwrite,
               output logic       jump,
               output logic [3:0] aluop);

  logic [8:0] controls;

  assign {regwrite, regdst, alusrc, branch, memwrite,
          memtoreg, jump, aluop} = controls;

  always_comb
    case(op)
      6'b000000: controls <= 11'b1100000_0010; // RTYPE
      6'b100011: controls <= 11'b1010010_0000; // LW
      6'b101011: controls <= 11'b0010100_0000; // SW
      6'b000100: controls <= 11'b0001000_0001; // BEQ
      6'b001000: controls <= 11'b1010000_0000; // ADDI
      //my impl start
      //6'b001100: controls <= 9'b101000000; // andi
      6'b001101: controls <= 11'b1010000_0011; // ori
      //6'b001110: controls <= 9'b101000000; // xori
      //6'b000101: controls <= 9'b101000000; // bne
      6'b001111: controls <= 11'b1010000_0100; // lui 
      //6'b000011: controls <= 9'b101000000; // jal  
      //my impl end
      6'b000010: controls <= 11'b0000001_0000; // J
      default:   controls <= 11'bxxxxxxx_xxxx; // illegal op
    endcase
endmodule
*/
module maindec(input  logic [5:0] op, funct,
               output logic [1:0] memtoreg, 
               output logic       memwrite,
               output logic       branch, alusrc,
               output logic [1:0] regdst, 
               output logic       regwrite,
               output logic [1:0] jump,
               output logic [3:0] aluop);

//
//上のビット数を変えたら，下のcontrolsのビット数とcontrols<=のビット数も変える必要がある．
//
  logic [13:0] controls;

  assign {regwrite, regdst, alusrc, branch, memwrite,
          memtoreg, jump, aluop} = controls;

  always_comb
    case(op)
      6'b000000: case(funct)
                    6'b001000: controls <= 14'b0_00_000_00_10_1000;//jr
                    default:   controls <= 14'b1_01_000_00_00_0010; //other RTYPE controls <= 12'b110000_00_0010; // RTYPE
                 endcase
      6'b100011: controls <= 14'b1_00_100_01_00_0000; // LW
      6'b101011: controls <= 14'b0_00_101_00_00_0000; // SW
      6'b000100: controls <= 14'b0_00_010_00_00_0001; // BEQ
      6'b000101: controls <= 14'b0_00_010_00_00_0001;//bne <----my impl.
      6'b001000: controls <= 14'b1_00_100_00_00_0000; // ADDI
      6'b000010: controls <= 14'b0_00_000_00_01_0000; // J
      6'b001111: controls <= 14'b1_00_100_00_00_0011; // lui 
      6'b001101: controls <= 14'b1_00_100_00_00_0100; // ori
      6'b001100: controls <= 14'b1_00_100_00_00_0101; // andi
      6'b001110: controls <= 14'b1_00_100_00_00_0111; // xori
      6'b000011: controls <= 14'b1_10_000_10_01_0000; //jal

      default:   controls <= 14'bx_xx_xxxx_xx_xxxx; // illegal op
    endcase
endmodule