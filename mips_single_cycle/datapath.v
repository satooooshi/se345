module datapath(input  logic        clk, reset,
                input  logic [1:0]   memtoreg, 
                input logic         pcsrc,
                input  logic        alusrc, 
                input  logic [1:0]  regdst,
                input  logic        regwrite,
                input  logic [1:0]  jump,
                input  logic [4:0]  alucontrol,
                output logic        zero,
                output logic [31:0] pc,
                input  logic [31:0] instr,
                output logic [31:0] aluout, writedata,
                input  logic [31:0] readdata);

  logic [4:0]  writereg;
  logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
  logic [31:0] signimm, signimmsh;
  logic [31:0] srca, srcb;
  logic [31:0] result;

  // next PC logic
  flopr #(32) pcreg(clk, reset, pcnext, pc);
  adder       pcadd1(pc, 32'b100, pcplus4);
  sl2         immsh(signimm, signimmsh);
  adder       pcadd2(pcplus4, signimmsh, pcbranch);

  //before instruction register
  mux2 #(32)  pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
  mux3 #(32)  pcmux(pcnextbr, /*JTA*/{pcplus4[31:28], 
                    instr[25:0], 2'b00}, srca, jump, pcnext);

  // register file logic
  regfile     rf(clk, regwrite, instr[25:21], instr[20:16], 
                 writereg, result, srca, writedata);

  //before register file
  mux3 #(5)   wrmux(instr[20:16], instr[15:11], /*$ra, $31*/5'b11111,
                    regdst, writereg);

  //after data memory
  mux3 #(32)  resmux(aluout, readdata, pcplus4,
                    memtoreg, result);

  signext     se(instr[15:0], signimm);

  //after register file
  // ALU logic
  mux2 #(32)  srcbmux(writedata, signimm, alusrc, srcb);
  alu         alu(srca, srcb, instr[10:6], alucontrol, aluout, zero);
endmodule