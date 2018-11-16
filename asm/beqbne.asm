addi $a0, $zero, 1 #n
addi $t0, $zero, 1 #num
addi $t1, $zero, 0 #sum

beq $t0, $a0, ENDIF
add $t1, $t1, 1 

ENDIF:
add $t1, $t1, 2

