module controller(input  logic [5:0] op, funct,
                  input  logic       zero,
                  output logic       memtoreg, memwrite,
                  output logic       pcsrc, alusrc,
                  output logic       regdst, regwrite,
                  output logic       jump,
                  output logic [4:0] alucontrol);

  logic [3:0] aluop;
  logic       branch;// for branch instruction(beq, bne)

  maindec md(op, memtoreg, memwrite, branch,
             alusrc, regdst, regwrite, jump, aluop);
  aludec  ad(funct, aluop, alucontrol);

  assign pcsrc = /*beq*/(op===6'b000100) & branch & zero | /*bne*/(op===6'b000101) & branch & (zero===0);
endmodule
