main:
addi $t1, $zero, 8
addi $t2, $zero, 2

addi $t3, $zero, -1
addi $t4, $zero, 10

addi $t5, $zero, 8
addi $t6, $zero, -2

addi  $sp, $sp, -8
sw    $ra, 4($sp)
sw    $s0, 0($sp)
beq $t1, $t5, BRANCHEQ
add $t2, $t1, $t2
add $t2, $t2, $t3
sub $t0, $t3, $t4
xor $t0, $t1, $t5
slt $t0, $t5, $t6

BRANCHEQ:
lw    $s0, 0($sp)
lw    $ra, 4($sp)
addi  $sp, $sp, 8
bne $t1, $t5, BRANCHNE

add $t2, $t2, $t3
sub $t2, $t2, $t4

BRANCHNE:
xori $t0, $t1, 8
slt $t0, $t5, $t6