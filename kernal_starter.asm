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
    addi $k1, $0, 15
    beq $v0, $k1, _syscall15 #jump to syscall 15 THIS IS THE BUZZER
    addi $k1, $0, 16
    beq $v0, $k1, _syscall16 #jump to syscall 16 THIS IS X FOR JOYSTICK
    addi $k1, $0, 17
    beq $v0, $k1, _syscall17 #jump to syscall 17 THIS IS Y FOR JOYSTICK
    addi $k1, $0, 18
    beq $v0, $k1, _syscall18 #jump to syscall 18 THIS IS FOR LED CONTROL
    # Add branches to any syscalls required for your stars.

    #Error state - this should never happen - treat it like an end program
    j _syscall10   # line 13

#Do init stuff
_syscall0:
    addi $sp, $sp, -4096
    la $k1, _END_OF_STATIC_MEMORY_          # Get the location out of static memory into k1
    sw $k1, -1024($t0)                      # Use 0xFFFFFEFC to store heap pointer

    # Initialization goes here
    j _syscallEnd_

#Print Integer
_syscall1:
    beq $a0, $0, _iszero

    addi $sp, $sp, -36       # Allocate space for 9 registers
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

    lw $t6, 32($sp)          # Restore addresses
    lw $t5, 28($sp)          
    lw $t4, 24($sp)          
    lw $t3, 20($sp)          
    lw $t2, 16($sp)          
    lw $t1, 12($sp)          
    lw $t0, 8($sp)           
    lw $a0, 4($sp)          
    lw $ra, 0($sp)           
    addi $sp, $sp, 36        # Deallocate stack space
    j _end

_iszero:
    addi $t0, $0, 48    # ASCII code for '0'
    sw $t0, -256($0)    # Print digit

_end:
    jr $k0                 # Return to caller





#Read Integer
_syscall5:
    # Read Integer code goes here
    # t0 is our bool for if the number is negative
    # v0 is our ongoing sum
    # t2 is the character in keyboard
    # t1 is 

    add $t0, $0, $0             # t0 = 0 because not negative
    add $v0, $0, $0             # This will be our ongoing total

    _first:
    lw $t5, -240($0)            # 0xFFFFFF10 = keyboard ready
    beq $t5, $0, _first         # if no keypress loop until keypress 
    lw $t2, -236($0)            # 0xFFFFFF14 = read keyboard character into $t2

    addi $t1, $0, 45            # Load ASCII value of negative ('-') into $t1, if the character is a minus ('-'), set t0 flag to 1
    bne $t2, $t1, _check0       # If $t2 isn't negative, then check if its 0
    addi $t0, $0, 1             # If $t2 is '-', then set t0 flag to 1
    sw $t0, -240($0)            # sw 0xFFFFFF10 = increment to next key as we only do mult when an int is found
    j _read                     # if $t2 is '-', then read next char

    _read: 
    lw $t5, -240($0)            # 0xFFFFFF10 = keyboard ready
    beq $t5, $0, _read          # if no keypress loop until keypress 
    lw $t2, -236($0)            # 0xFFFFFF14 = read keyboard character into $t2

    _check0:
    addi $t1, $0, 48            # Load ASCII value of 0 ('0') into $t1, if the character is 0 ('0'), add that as the next num
    bne $t2, $t1, _check1       # If $t2 isn't '0', then check if its '1'
    addi $t3, $0, 0             # If $t2 is '0', then mark that as next var
    j _mult

    _check1:
    addi $t1, $0, 49            # Load ASCII value of 1 ('1') into $t1, if the character is 1 ('1'), add that as the next num
    bne $t2, $t1, _check2       # If $t2 isn't '1', then check if its '2'
    addi $t3, $0, 1             # If $t2 is '1', then mark that as next var
    j _mult

    _check2:
    addi $t1, $0, 50            # Load ASCII value of 2 ('2') into $t2, if the character is 2 ('2'), add that as the next num
    bne $t2, $t1, _check3       # If $t2 isn't '2', then check if its '3'
    addi $t3, $0, 2             # If $t2 is '2', then mark that as next var
    j _mult

    _check3:
    addi $t1, $0, 51            # Load ASCII value of 3 ('3') into $t2, if the character is 3 ('3'), add that as the next num
    bne $t2, $t1, _check4       # If $t2 isn't '3', then check if its '4'
    addi $t3, $0, 3             # If $t2 is '3', then mark that as next var
    j _mult

    _check4:
    addi $t1, $0, 52            # Load ASCII value of 4 ('4') into $t2, if the character is 4 ('4'), add that as the next num
    bne $t2, $t1, _check5       # If $t2 isn't '4', then check if its '5'
    addi $t3, $0, 4             # If $t2 is '4', then mark that as next var
    j _mult

    _check5:
    addi $t1, $0, 53            # Load ASCII value of 5 ('5') into $t2, if the character is 5 ('5'), add that as the next num
    bne $t2, $t1, _check6       # If $t2 isn't '5', then check if its '6'
    addi $t3, $0, 5             # If $t2 is '5', then mark that as next var
    j _mult

    _check6:
    addi $t1, $0, 54            # Load ASCII value of 6 ('6') into $t2, if the character is 6 ('6'), add that as the next num
    bne $t2, $t1, _check7       # If $t2 isn't '6', then check if its '7'
    addi $t3, $0, 6             # If $t2 is '6', then mark that as next var
    j _mult
    
    _check7:
    addi $t1, $0, 55            # Load ASCII value of 7 ('7') into $t2, if the character is 7 ('7'), add that as the next num
    bne $t2, $t1, _check8       # If $t2 isn't '7', then check if its '8'
    addi $t3, $0, 7             # If $t2 is '7', then mark that as next var
    j _mult

    _check8:
    addi $t1, $0, 56            # Load ASCII value of 8 ('8') into $t2, if the character is 8 ('8'), add that as the next num
    bne $t2, $t1, _check9       # If $t2 isn't '8', then check if its '9'
    addi $t3, $0, 8             # If $t2 is '8', then mark that as next var
    j _mult

    _check9:
    addi $t1, $0, 57            # Load ASCII value of 9 ('9') into $t2, if the character is 9 ('9'), add that as the next num
    bne $t2, $t1, _int_end      # If $t2 isn't '9', then it isnt an integer
    addi $t3, $0, 9             # If $t2 is '9', then mark that as next var

    _mult:
    sw $t0, -240($0)            # sw 0xFFFFFF10 = increment to next key as we only do mult when an int is found
    addi $t4, $0, 10            # Load 10 into $k1
    mult $v0, $t4               # Multiply $v1 by 10
    mflo $v0                    # Move the result from LO to $v0
    add $v0, $v0, $t3           # add the next digit to $v0
    j _read                     # Read the next

    _int_end:
    beq $t0, $0, _nonnegative
    sub $v0, $0, $v0

    _nonnegative:
    jr $k0


#Heap allocation
_syscall9:
    # Heap allocation code goes here
    lw $t0, -1024($t0)                      # Get heap pointer from 0xFFFFFEFC
    
    add $v0, $0, $t0                        # to return: The address of the requested heap
    add $t0, $a0, $t0
    sw $t0, -1024($t0)

    jr $k0


#"End" the program
_syscall10:
    j _syscall10


#print character 
_syscall11:
    sw $a0, -256($0) 
    jr $k0


#read character
_syscall12:
    lw $t0, -240($0)         #0xFFFFFF10 = keyboard ready
    beq $t0, $0, _syscall12     #if no keypress loop until keypress 

    lw $v0, -236($0)         #0xFFFFFF14 = read keyboard character into $v0

    jr $k0

#play buzzer
_syscall15:
    sw $a0, -200($0)         #0xFFFFFF38 = Set Volume
    sw $a1, -204($0)         #0xFFFFFF34 = Set Frequency
    addi $t0, $0, 1
    sw $t0, -208($0)         #0xFFFFFF30 = Play Noise
    jr $k0

#read X from Joystick
_syscall16:
    lw $v0, -196($0)         #0xFFFFFF3C = read X
    jr $k0

#read Y from Joystick
_syscall17:
    lw $v0, -192($0)         #0xFFFFFF40 = read Y
    jr $k0

#LED Control
_syscall18:
    sw $a0, -188($0)         #0xFFFFFF44 = display   
    jr $k0

#extra challenge syscalls go here?
_syscallEnd_: