.data
    notes: .word 220 247 294 294 330 349 440 494 523 587 659 587 523 494 220 294 440 220
    volume: .word 5 5 6 7 8 10 10 4 6 10 9 8 6 4 7 8 9 10
.text
.globl main

#
# A = 220
# B = 247
# C = 261 
# D = 294
# E = 330
# F = 349
# G = 392
# A = 440 
# B = 494 
# C = 523
# D = 587
# E = 659
# 
    la $s0, notes
    la $s1, volume
main: 
    lw $a1, 0($s0)
    lw $a0, 0($s1)

    addi $s0, $s0, 4
    addi $s1, $s1, 4

    addi $v0, $0, 13  
    syscall

    addi $t0, $0, 100
    addi $t1, $0, 0
delay:
    addi $t0, $t0, -1
    bne $t0, $t1 delay

    j main