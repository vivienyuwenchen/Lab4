main:
addi $t1, $zero, 8
addi $t2, $zero, 2

addi $t3, $zero, -1
addi $t4, $zero, 10

addi $t5, $zero, 8
addi $t6, $zero, -2
sw $ra, $t1
beq $t1, $t5, BRANCH 
add $t2, $t1, $t2
addi $t2, $t2, $t3
addi  $t2, $t2, $t4
subi $t0, $t3, $t4
slt $t0, $t5, $t6

BRANCH:
lw $ra, $t1