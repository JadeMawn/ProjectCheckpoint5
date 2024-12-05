.data
    notes: .word 330 0 294 0 261 0 294 0 330 0 330 0 330 0 294 0 294 0 294 0 330 0 392 0 392 0 330 0 294 0 261 0 294 0 330 0 330 0 330 0 294 0 294 0 294 0 330 0 294 0 261 0
    volume: .word 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6
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
    addi $a2, $0, 0
main: 
    lw $a1, 0($s0)
    lw $a0, 0($s1)

    addi $s0, $s0, 4
    addi $s1, $s1, 4

    addi $v0, $0, 15    #set
    syscall

    addi $a1, $0, 1
    addi $v0, $0, 14    #play
    syscall

    j main