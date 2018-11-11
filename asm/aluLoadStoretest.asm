main:
addi $t1, $zero, 5
addi $t2, $zero, 2

addi $t3, $zero, -1
addi $t4, $zero, 10
addi  $sp, $sp, -12	# Allocate three words on stack at once for three pushes
sw    $ra, 8($sp)	# Push ra on the stack (will be overwritten by Fib function calls)
sw    $s0, 4($sp)	# Push s0 onto stack
sw    $s1, 0($sp)	# Push s1 onto stack

addi $t5, $zero, 8
addi $t6, $zero, -2

xori $t1, $t1, 2
sub  $t4, $t4, $t2,
slt $t0, $t5, $t6

lw    $s1, 0($sp)	# Pop s1 from stack
lw    $s0, 4($sp)	# Pop s0 from stack
lw    $ra, 8($sp)	# Pop ra from the stack so we can return to caller
addi  $sp, $sp, 12	# Adjust stack pointer to reflect pops
