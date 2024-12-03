.data
    my_func_addr: .word 1 2 3 4
.text

addi $a0, $0, 12    # 12 bytes of mem
addi $v0, $0, 9     # 9 for heap allocation
syscall

add $a0, $v0, 0     # move response from syscall to pring
addi $v0, $0, 1     # 1 for print int
syscall
