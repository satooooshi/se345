module datapath(input logic clk, reset,
                input logic memtoreg, pcsrc,
                input logic alusrc, regdst,
                input logic regwirte, jump,
                input logic [2:0] alucontrol,
                output logic zero,
                output logic [31:0] pc,
                output logic [31:0] instr,
                output logic [31:0] aluout, writedata_rd2,
                input logic [31:0] readdata_rd);

logic [4:0] writereg_r3;
logic [31:0] pcnext, pcnextbr, pcplus4;
logic [31:0] signimm, signimmsh;
logic [31:0] srca, srcb_ofalu;
logic [31:0] result_to_wd3;

//datapath below register file
flopr #(32) pcreg(clk, reset, pcnext, pc);
adder pcadd1(pc, 32'b100, pcplus4);
signext se(instr[15:0], signimm);// 16bit -> 32bit
sl2 immsh(signimm, signimmsh);
adder pcadd2(signimmsh, pcplus4, pcbranch);
mux #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
mux #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], jump, 2'b00}, pcnext);

regfile rf(clk, regwirte, instr[25:21],   instr[20:16],  writereg_r3, 
                          result_to_wd3,  srca,          writedata_rd2);

//datapath before register file
mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg_r3);


//datapath after dmem
mux2 #(32) resmux_aluout_dmemout(aluout, readdata_rd, memtoreg, result_to_wd3);

//alu logic 
//datapath after register file
mux2 #(32) srcbmux_toalu(writedata_rd2, signimm, alusrc, srcb_ofalu);
//alu
endmodule

