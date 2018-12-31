# mipstest.asm
# David_Harris@hmc.edu 9 November 2005 
#
# Test the MIPS processor.
# add, sub, and, or, slt, addi, lw, sw, beq, j
# If successful, it should write the value 7 to address 84

#       Assembly            Description          Address Machine                         
main:    
	addi $2, $0, 0xc
	jr $2
	j endnotbyjr
endbyjr:
	addi $2, $0, 0x7 
	sw   $2, 84($0)     # write adr 84 = 7   44      ac020054
	j end
endnotbyjr: 
	addi $2, $0, 0x3
	sw   $2, 84($0)     # write adr 84 = 0   44      ac020054
end:
