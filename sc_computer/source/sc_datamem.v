/*
module sc_datamem (addr,datain,dataout,we,clock,mem_clk,dmem_clk);
 
   input  [31:0]  addr;
   input  [31:0]  datain;
   
   input          we, clock,mem_clk;
   output [31:0]  dataout;
   output         dmem_clk;
   
   wire           dmem_clk;    
   wire           write_enable; 
   assign         write_enable = we & ~clock; 
   
   assign         dmem_clk = mem_clk & ( ~ clock) ; 
	
	//For calcurator
	input load_enable;
	input [31:0] digit_from_io;
	reg data_in;
	reg address_from_io;
	
	always_comb@
		begin
			if(load_enable)
				begin
					data_in=digit_from_io;
					address_from_io==5'b00100;
				end
			else
				begin
					data_in=datain;
					address_from_io=addr[6:2];
				end
		end
   
   lpm_ram_dq_dram  dram(addr[6:2]address_from_io,dmem_clk,dataindata_in,write_enable,dataout );

endmodule 
*/

module sc_datamem(resetn, addr, datain, dataout, we, clock, mem_clk, dmem_clk,
	sw, key, hex5, hex4, hex3, hex2, hex1, hex0, led);
	input              resetn;
	input      [31:0]  addr, datain;
	input              we, clock, mem_clk;
	input      [9:0]   sw;
	input      [3:1]   key;
	output reg [31:0]  dataout;
	output             dmem_clk;
	
	reg [31:0] digit0, digit1;
	output reg [6:0]   hex5, hex4, hex3, hex2, hex1, hex0;
	output reg [9:0]   led;
	wire               write_enable;
	wire       [31:0]  mem_dataout;

	assign write_enable = we & (~clock) & (addr[31:8] != 24'hffffff);
	assign dmem_clk = mem_clk & (~clock);

	lpm_ram_dq_dram dram(addr[6:2], dmem_clk, datain, write_enable, mem_dataout);
	
	sevenseg hi_digit(digit1,hex1);
	sevenseg low_digit(digit0,hex0);
	//not use this time
	reg [31:0] msbs, lsbs;
	sevenseg hex2_display(32'hffffffff,hex2);
	sevenseg hex3_display(32'hffffffff,hex3);
	sevenseg hex4_display(32'hffffffff,hex4);
	sevenseg hex5_display(32'hffffffff,hex5);
	
	// IO ports design.
	//sw
	always @(posedge dmem_clk or negedge resetn) begin
		if (~resetn) begin // reset hexs and leds
			//hex0 <= 7'b1111111;
			//hex1 <= 7'b1111111;
			//hex2 <= 7'b1111111;
			//hex3 <= 7'b1111111;
			//hex4 <= 7'b1111111;
			//hex5 <= 7'b1111111;
			digit0 <= 32'hffffffff;
			digit1 <= 32'hffffffff;
			msbs <= 32'hffffffff;
			lsbs <= 32'hffffffff;
			led <= 10'b0000000000;
		end else if (we) begin // write when dmem_clk posedge comes
			case (addr)
				32'hffffff20: 
					begin 
						digit0 <= datain;		//sw $t1, 0xffffff20($0)
						
					end
				32'hffffff30: 
					begin
						digit1 <= datain;		//sw $t2, 0xffffff30($0)
						
					end
				32'hffffff40: msbs <= datain;
				32'hffffff50: lsbs <= datain;
				//32'hffffff60: hex4 <= datain[6:0];
				//32'hffffff70: hex5 <= datain[6:0];
				32'hffffff80: led <= datain[9:0]; //sw $s1, 0xffffff80($0) 
			endcase
		end
	end

	//lw
	always @(posedge dmem_clk) begin // read when dmem_clk posedge comes
		case (addr)
			//directly read IO instead of loading dram => goes to WD3
			32'hffffff00: dataout <= {22'b0, sw};
			32'hffffff10: dataout <= {28'b0, key, 1'b1}; // can only read key[3..1], key0 is used for reset
			default: dataout <= mem_dataout;// normal lw inst.
		endcase
	end
	
endmodule