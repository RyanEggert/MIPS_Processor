addi $t0, $zero, 1
addi $t1, $zero, 10
addi $t2, $zero, 100

add $t3, $t1, $t2  # $t3 = 10 + 100 = 110
add $t4, $t3, $t1  # $t4 = 110 + 10 = 120
add $t5, $t1, $t4  # $t5 = 1 + 120 = 121

addi $v0, $zero, 10
syscall