addi $v0, $0, 5    # 5 for read int
syscall

add $a0, $v0, 0     # move response from syscall to print
addi $v0, $0, 1     # 1 for print int
syscall