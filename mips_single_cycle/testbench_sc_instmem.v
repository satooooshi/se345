//mips assembler
//http://www.kurtm.net/mipsasm/index.cgi

module testbench_sc_instmem();

  logic        clk;
  logic        reset;

  logic [31:0] writedata, dataadr, pc, instr;
  logic        memwrite;

  // instantiate device to be tested
  top dut(clk, reset, writedata, dataadr, pc, instr, memwrite);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    begin
      if(memwrite) begin
        if(dataadr === 84 & writedata === 7) begin
          $display("Single cycle mips : Simulation succeeded");
          $stop;
        end else if (dataadr !== 80) begin
          $display("Single cycle mips : Simulation failed");
          $stop;
        end
      end
    end
endmodule