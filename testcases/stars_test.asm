addi $a1, $0, 60    # 60 freq
addi $a0, $0, 10    # 10 for Volume
addi $v0, $0, 15    # 15 for buzzer
syscall

add $a0, $v0, 15    # colors
addi $v0, $0, 18    # 18 for LED
syscall

addi $v0, $0, 16    # 16 for get X
syscall

add $a0, $v0, 0     # move response from syscall to print
addi $v0, $0, 1     # 1 for print int
syscall

addi $v0, $0, 17    # 17 for get Y
syscall

add $a0, $v0, 0     # move response from syscall to print
addi $v0, $0, 1     # 1 for print int
syscall