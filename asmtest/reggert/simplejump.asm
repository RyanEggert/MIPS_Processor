addi $sp, $zero, 0x00003ffc
addi $t0, $zero, 1
addi $t1, $zero, 10
addi $t2, $zero, 100

add $t3, $t1, $t2  # $t3 = 10 + 100 = 110
add $t4, $t3, $t1  # $t4 = 110 + 10 = 120
add $t5, $t1, $t4  # $t5 = 1 + 120 = 130
j end
add $t6, $t0, $t0  # We should not see 2 in $t6. This line should not be run

end:
slt $t7, $t1, $t2   # $t7 = 1, b/c 10 < 100
addi $v0, $zero, 10 # Set syscall buffer
syscall	# Stop execution
