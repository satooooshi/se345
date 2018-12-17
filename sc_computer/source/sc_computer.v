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
/*  
 module sc_computer (resetn,clock,mem_clk,pc,inst,aluout,memout,imem_clk,dmem_clk,out_port0,out_port1,in_port0,in_port1,calc_key,mem_dataout,data,io_read_data);

	input resetn,clock,mem_clk;
   
   input [31:0] in_port0,in_port1;
	input calc_key;
	output [7:0] led;
   
   output [31:0] pc,inst,aluout,memout;
   output        imem_clk,dmem_clk;
   output [31:0] out_port0,out_port1;
   output [31:0] mem_dataout;            // to check data_mem output
   output [31:0] data;
   output [31:0] io_read_data;
   
   wire   [31:0] data;
   wire          wmem;   // connect the cpu and dmem. 
*/
	
	
 //"calc_io.hex",
module sc_computer ( resetn,clock,mem_clk, pc, inst, aluout ,memout, imem_clk, dmem_clk, 
								sw, key, hex5, hex4, hex3, hex2, hex1, hex0, led 
								,out_port0,out_port1 );
								
	input resetn,clock,mem_clk;
   output [31:0] pc,inst,aluout,memout;
   output        imem_clk,dmem_clk;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
 
  //"sc_instmem.hex",
	//for calculator
	input [9:0] sw;
	input [3:1] key;
	output [6:0] hex5, hex4, hex3, hex2, hex1, hex0;
	output [9:0] led;
	
	output [31:0] out_port0,out_port1;
	
	
   sc_cpu cpu (clock,resetn,inst,memout,pc,wmem,aluout,data);          // CPU module.
   sc_instmem  imem (pc,inst,clock,mem_clk,imem_clk);                  // instruction memory.
   sc_datamem  dmem (resetn, aluout,data,memout,wmem,clock,mem_clk,dmem_clk, 
								sw, key, hex5, hex4, hex3, hex2, hex1, hex0, led); // data memory.
								
	assign out_port0=inst;
	assign out_port1=aluout;
	
endmodule



