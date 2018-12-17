/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

/*
module sc_computer (resetn,clock,mem_clk,pc,inst,aluout,memout,imem_clk,dmem_clk, );
   
   input resetn,clock,mem_clk;
   output [31:0] pc,inst,aluout,memout;
   output        imem_clk,dmem_clk;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
 */

 //"sc_instmem.hex",
 module sc_computer_with_io (resetn,clock,mem_clk,pc,inst,aluout,memout,imem_clk,dmem_clk,out_port0,out_port1,in_port0,in_port1,mem_dataout,data,io_read_data);

	input resetn,clock,mem_clk;
   
   input [31:0] in_port0,in_port1;
   
   output [31:0] pc,inst,aluout,memout;
   output        imem_clk,dmem_clk;
   output [31:0] out_port0,out_port1;
   output [31:0] mem_dataout;            // to check data_mem output
   output [31:0] data;
   output [31:0] io_read_data;
   
   wire   [31:0] data;
   wire          wmem;   // connect the cpu and dmem. 
	

   sc_cpu cpu (clock,resetn,inst,memout,pc,wmem,aluout,data);          // CPU module.
   sc_instmem  imem (pc,inst,clock,mem_clk,imem_clk);                  // instruction memory.
   sc_datamem  dmem (resetn, aluout,data,memout,wmem,clock,mem_clk,dmem_clk); // data memory.
	
	assign out_port0=inst;
	
endmodule



