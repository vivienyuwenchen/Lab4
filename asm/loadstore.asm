
addi  $sp, $sp, -12	# Allocate three words on stack at once for three pushes
addi  $t0, $zero, 5
addi  $t2, $zero, 5
addi  $t3, $zero, 5
addi  $t4, $zero, 5
addi  $t5, $zero, 5
sw    $t0, 8($sp)	# Push ra on the stack (will be overwritten by Fib function calls)
	# Push s1 onto stack
addi  $t0, $zero, 6
addi  $t2, $zero, 6
addi  $t3, $zero, 6
addi  $t4, $zero, 6
addi  $t5, $zero, 6

lw    $s1, 4($sp)	# Pop s1 from stack
addi  $t1, $s1, 5	# Adjust stack pointer to reflect pops
