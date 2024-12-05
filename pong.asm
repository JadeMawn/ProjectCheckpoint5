

create_design:
    # Set s6 to white that we will use for walls.
    add $s6, $0, 16777215

    # Set s7 to be a light gray color that we will use for score.
    add $s7, $0, 13882323

    # Set s1 to the Y height of P1
    addi $s1, $0, 12
    # Set s2 to the Y height of P2
    addi $s2, $0, 12

    # dual loops for background
    addi $t3, $0, 36
    addi $t4, $0, 1
    sw $0, -216($0) #Color
    start_dual:
        beq $t3, $t4, end_dual
        addi $t0, $0, 24
        addi $t1, $0, 1
        sw $t4, -224($0) #X cord
        start_dual_vertical:
            beq $t1, $t0, end_dual_vertical
            sw $t1, -220($0) #Y cord
            sw $0, -212($0)
            addi $t1, $t1, 1
            j start_dual_vertical

        end_dual_vertical:
        addi $t4, $t4, 1
    j start_dual

    end_dual:

    # loop for verticals lines
    addi $t0, $0, 24
    addi $t1, $0, 1
    addi $t2, $0, 1
    sw $t2, -224($0) #X cord
    sw $s6, -216($0) #Color
    start_l_vertical:
        beq $t1, $t0, end_l_vertical
        sw $t1, -220($0) #Y cord
        sw $0, -212($0)
        addi $t1, $t1, 1
        j start_l_vertical

    end_l_vertical:

    addi $t1, $0, 1
    addi $t2, $0, 36
    sw $t2, -224($0) #X cord
    start_r_vertical:
        beq $t1, $t0, end_r_vertical
        sw $t1, -220($0) #Y cord
        sw $0, -212($0)
        addi $t1, $t1, 1
        j start_r_vertical

    end_r_vertical:

    # loop for horizontal lines
    addi $t0, $0, 36
    addi $t1, $0, 1
    addi $t2, $0, 1
    sw $t2, -220($0) #Y cord
    start_t_horizontal:
        beq $t1, $t0, end_t_horizontal
        sw $t1, -224($0) #Y cord
        sw $0, -212($0)
        addi $t1, $t1, 1
        j start_t_horizontal

    end_t_horizontal:

    addi $t1, $0, 1
    addi $t2, $0, 23
    sw $t2, -220($0) #Y cord
    start_b_horizontal:
        beq $t1, $t0, end_b_horizontal
        sw $t1, -224($0) #Y cord
        sw $0, -212($0)
        addi $t1, $t1, 1
        j start_b_horizontal

    end_b_horizontal:

    sw $s0, -224($0) #0xFFFFFF20 = monitor x coordinate
    sw $s1, -220($0) #0xFFFFFF24 = monitor y coordinate
    sw $t0, -216($0) #0xFFFFFF28 = monitor color
    sw $0, -212($0)  #0xFFFFFF2C = write pixel


move_p1_up:
    #a0: p1 location is in
