main:
addi $t1, $zero, 8
addi $t2, $zero, 2

addi $t3, $zero, -1
addi $t4, $zero, 10
addi $t5, $zero, 8

addi  $sp, $sp, -8
sw    $ra, 4($sp)
sw    $s0, 0($sp)
beq $t1, $t5, BRANCH 
add $t2, $t1, $t2
add $t2, $t2, $t3


BRANCH:
lw    $s0, 0($sp)
lw    $ra, 4($sp)
addi  $sp, $sp, 8

