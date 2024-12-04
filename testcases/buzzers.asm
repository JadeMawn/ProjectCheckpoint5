addi $a1, $0, 180   # 180 freq
addi $a0, $0, 10    # 10 for Volume
addi $v0, $0, 13    # 15 for buzzer3
syscall
addi $a1, $0, 120   # 120 freq
addi $a0, $0, 10    # 10 for Volume
addi $v0, $0, 14    # 15 for buzzer2
syscall
addi $a1, $0, 60    # 60 freq
addi $a0, $0, 10    # 10 for Volume
addi $v0, $0, 15    # 15 for buzzer
syscall