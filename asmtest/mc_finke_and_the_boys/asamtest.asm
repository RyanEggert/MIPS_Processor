addi $sp, $zero, 0x00003ffc
xori $t0, $zero, 15
xori $t1, $zero, 100
jal sectionOne
j endScript


sectionOne:
    	slt $t2, $t1, $t0
    	bne $t2, $zero, sectionTwo
	sub $t1, $t1, $t0
	sub $t0, $t0, 1
	bne $t0, $zero, sectionOne
	jr $ra
	
sectionTwo:
	slt $t2, $t0, $t1
	bne $t2, $zero, sectionOne
	add $t1, $t1, $t0
	sub $t0, $t0, 1
	bne $t0, $zero, sectionTwo
	jr $ra

endScript:
	addi $v0, $zero, 10
	syscall