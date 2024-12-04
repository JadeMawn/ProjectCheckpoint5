#printing integer and character test

main: 

    #print 32767 with syscall 1
    addi $a0, $0, 32767
    addi $v0, $0, 1
    syscall

    addi $a0, $0, -32767
    addi $v0, $0, 1
    syscall

    addi $a0, $0, 0
    addi $v0, $0, 1
    syscall

    addi $a0, $0, 1000
    addi $v0, $0, 1
    syscall

    #print 'w' with syscall 9
    addi $a0, $0, 119
    addi $v0, $0, 11
    syscall

    addi $v0, $0, 12
    syscall

    add $a0, $0, $v0
    addi $v0, $0, 11
    syscall

