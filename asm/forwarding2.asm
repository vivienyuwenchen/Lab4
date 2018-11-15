main:
addi $t1, $zero, 1
addi $t2, $zero, 2

addi $t3, $zero, 3
addi $t4, $zero, 4

addi $t5, $zero, 5

add $t6, $t1, $t5
addi $t1, $t2, 1
add $t2, $t6, $t4
add $t7, $t1, $t5
add $t3, $t3, $t5