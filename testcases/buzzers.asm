addi $a1, $0, 300   # freq
addi $a0, $0, 6     # vol
addi $a2, $0, 0     # buzzer num
addi $v0, $0, 15    
syscall

addi $a0, $0, 1
addi $v0, $0, 14    #play
syscall

addi $a2, $0, 1     # buzzer num
addi $v0, $0, 15    
syscall

addi $a0, $0, 1
addi $v0, $0, 14    #play
syscall