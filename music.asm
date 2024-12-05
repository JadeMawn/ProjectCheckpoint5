.data
    notes: .word 330 294 261 294 330 330 330 294 294 294 330 392 392 330 294 261 294 330 330 330 294 294 294 330 294 261
    volume: .word 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6
    num: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.globl main

# A = 220, B = 247, C = 261 
# D = 294, E = 330, F = 349
# G = 392, A = 440, B = 494 
# C = 523, D = 587, E = 659

    la $s0, notes
    la $s1, volume
    la $s2, num
main: 
    lw $a1, 0($s0)
    lw $a0, 0($s1)
    lw $a2, 0($s2)
    lw $a2, 0($s2)

    addi $s0, $s0, 4
    addi $s1, $s1, 4
    addi $s2, $s2, 4
    addi $s2, $s2, 4

    addi $v0, $0, 15    #set
    syscall

    addi $a0, $0, 1
    addi $v0, $0, 14    #play
    syscall

    bne $a2, $0, main
    addi $a0, $0, 0     # add pause for speaker 0
    addi $v0, $0, 14    #play
    syscall

    j main