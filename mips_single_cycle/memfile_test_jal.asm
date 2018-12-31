
#       Assembly            Description          Address Machine                         
main:    
    addi $2, $0, 0x1
    jal middle
    j true
middle:
    jr $31
    j false             # should not reach here!!
true: 
    addi $2, $0, 0x7
    sw   $2, 84($0)     # write adr 84 = 7   
    j end
false:
    addi $2, $0, 0x3
	sw   $2, 84($0)     # write adr 84 = 3   
end:

