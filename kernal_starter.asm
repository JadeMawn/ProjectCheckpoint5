#This is starter code, so that you know the basic format of this file.
#Use _ in your system labels to decrease the chance that labels in the "main"
#program will conflict


### DO NOT EDIT ORIGINAL REFERENCE ###

.data
.text
_syscallStart_:
    beq $v0, $0, _syscall0 #jump to syscall 0
    addi $k1, $0, 1
    beq $v0, $k1, _syscall1 #jump to syscall 1
    addi $k1, $0, 5
    beq $v0, $k1, _syscall5 #jump to syscall 5
    addi $k1, $0, 9
    beq $v0, $k1, _syscall9 #jump to syscall 9
    addi $k1, $0, 10
    beq $v0, $k1, _syscall10 #jump to syscall 10
    addi $k1, $0, 11
    beq $v0, $k1, _syscall11 #jump to syscall 11
    addi $k1, $0, 12
    beq $v0, $k1, _syscall12 #jump to syscall 12
    # Add branches to any syscalls required for your stars.

    #Error state - this should never happen - treat it like an end program
    j _syscall10   # line 13

#Do init stuff
_syscall0:
    addi $sp, $sp, -4096
    # Initialization goes here
    j _syscallEnd_

#Print Integer
_syscall1:
    beq $a0, $0, _iszero

    addi $sp, $sp, -36       # Allocate space for 10 registers
    sw $ra, 0($sp)           # Save return registers
    sw $a0, 4($sp)            
    sw $t0, 8($sp)           
    sw $t1, 12($sp)          
    sw $t2, 16($sp)          
    sw $t3, 20($sp)          
    sw $t4, 24($sp)          
    sw $t5, 28($sp)          
    sw $t6, 32($sp)          

    # Handle negative numbers
    addi $t0, $0, 0     # $t0 = 0
    slt $t1, $a0, $t0      # Check if $a0 < 0
    beq $t1, $0, _notnegative  # Skip if not negative
    addi $t0, $0, -1    # $t0 = -1
    mult $a0, $t0          # Multiply $a0 by -1
    mflo $a0               # Store the positive value of $a0
    addi $t0, $0, 45    # ASCII code for '-'
    sw $t0, -256($0)    # Print '-'

_notnegative:
    # Prepare divisor
    addi $t6, $0, 1     # Initialize divisor
    addi $t2, $0, 10    # Multiplier for building divisor

_builddivisor:
    mult $t6, $t2          # Multiply current divisor by 10
    mflo $t6               # Update divisor
    slt $t0, $t6, $a0      # Check if divisor <= $a0
    beq $t0, $0, _printdigits  # Stop if divisor > $a0
    j _builddivisor         # Continue building divisor

_printdigits:
    addi $t4, $0, 0     # Leading 0 suppression flag

_nextdigit:
    div $a0, $t6           # Divide $a0 by divisor
    mflo $t3               # Extract the current digit
    mfhi $a0               # Update $a0 to remainder
    beq $t4, $0, _checkdigit  # Skip leading 0s if flag not set
    j _outputdigit          # Print digit

_checkdigit:
    beq $t3, $0, _skip  # Skip leading 0s
    addi $t4, $0, 1     # Set flag to start printing digits

_outputdigit:
    addi $t5, $t3, 48      # Convert digit to ASCII
    sw $t5, -256($0)    # Print digit

_skip:
    div $t6, $t2          # Reduce divisor by a factor of 10
    mflo $t6               # Update divisor
    bne $t6, $0, _nextdigit  # Continue if divisor > 0

    lw $t6, 32($sp)          # Restore $t6
    lw $t5, 28($sp)          # Restore $t5
    lw $t4, 24($sp)          # Restore $t4
    lw $t3, 20($sp)          # Restore $t3
    lw $t2, 16($sp)          # Restore $t2
    lw $t1, 12($sp)          # Restore $t1
    lw $t0, 8($sp)           # Restore $t0
    lw $a0, 4($sp)           # Restore $a0
    lw $ra, 0($sp)           # Restore return address
    addi $sp, $sp, 36        # Deallocate stack space
    j _end

_iszero:
    addi $t0, $0, 0    # ASCII code for '-'
    sw $t0, -256($0)    # Print digit

_end:
    jr $k0                 # Return to caller


#Read Integer
_syscall5:
    # Read Integer code goes here

    jr $k0

#Heap allocation
_syscall9:
    # Heap allocation code goes here
    jr $k0

#"End" the program
_syscall10:
    j _syscall10

#print character
_syscall11:
    lw $t0, 0($a0)            # Load character from $a0

    sw $t0, -256($0) 
    
    jr $k0

#read character
_syscall12:
    # read character code goes here
    lw $t0, -240($0) #0xFFFFFF10 = keyboard ready
    beq $t0, $0, _syscall12 #if no keypress loop until keypress 

    lw $v0, -236($0) #0xFFFFFF14 = read keyboard character into $v0

    jr $k0

#extra challenge syscalls go here?
_syscallEnd_: