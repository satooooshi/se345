module datamem_calc_tb;

	reg              resetn;
	reg      [31:0]  addr, datain;
	reg              we, clock, mem_clk;
	reg      [9:0]   sw;
	reg      [3:1]   key;
	wire [31:0]  dataout;
	wire             dmem_clk;
	wire [6:0]   hex5, hex4, hex3, hex2, hex1, hex0;
	wire [9:0]   led;
	
sc_datamem sc_datamem_dut(resetn, addr, datain, dataout, we, clock, mem_clk, dmem_clk,
	sw, key, hex5, hex4, hex3, hex2, hex1, hex0, led);
	
	
	initial begin // Generate a reset signal at the start.
		//negedge
		resetn = 0;
		while (1)
			#5 resetn = 1;
		end
	
	initial
        begin
            clock = 1;
            while (1)
                #2  clock = ~clock;
        end

	   
	 initial
        begin
            mem_clk = 1;
            while (1)
                #1  mem_clk = ~ mem_clk;
        end
		  
	 
	 
	 initial 
		begin
			//test lw
			sw = 10'b1111100000;
			addr=32'hffffff00;
			key <= 3'b101; // key2 pressed, should change to sub mode
			#10;
			sw = 10'b1111100000;
			addr=32'hffffff00;
			key <= 3'b011; // key1 pressed, should change to add mode
			#10;
			sw = 10'b1111100000;
			addr=32'hffffff10;// dataout <= { key }
			key <= 3'b011; // key1 pressed, should change to add mode
			#10;
			sw = 10'b1111100000;
			addr=32'hffffff10;
			key <= 3'b110; // key3 pressed, should change to xor mode
			#10;
			
			//test sw
			we =1;
			addr=32'hffffff20;
			datain=32'b1000;//8 in decimal, hex0 shold be 7'b0000000
			#10;
			we =1;
			addr=32'hffffff30;
			datain=32'b0011;//3 in decimal, hex1 shold be 7'b011_0000;
			#10;
			
		end
	



endmodule 