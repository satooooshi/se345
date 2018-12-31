# mipstest.asm
# David_Harris@hmc.edu 9 November 2005 
#
# Test the MIPS processor.
# add, sub, and, or, slt, addi, lw, sw, beq, j
# If successful, it should write the value 7 to address 84

#       Assembly            Description          Address Machine                       
main:   lui $2, 0x6d5e	    	#a=0x6d5e0000
				#ori $2, $2, 0x4f3c	#a=0x6d5e4f3c
	j end
end:    sw   $2, 84($0)     # write adr 84 = 7   44      ac020054
