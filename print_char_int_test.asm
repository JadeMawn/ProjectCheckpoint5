#printing integer and character test

main: 
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