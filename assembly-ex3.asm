.data
array1: .word -85, 36, -94, 45, 29, 85, -12, 89, -20, 4
array2: .word 4, -81, 134, 27, -9
array3: .word 1, 21, 49, 68, 95, 134, 225, 492, 697, 767, 812, 957, 1050, 13
length1: .word 10
length2: .word 5
length3: .word 14

.text

# Sorting array1
 la $s0,array1
 lw $s3,length1
la $a0, array1
la $a2, array1
lw $a1, length1
sll $a1, $a1, 2
sub $a1, $a1, 4
jal bubbleSort

# Sorting array2
 la $s1,array2
 lw $s4,length2
la $a0, array2
la $a2, array2
lw $a1, length2
sll $a1, $a1, 2
sub $a1, $a1, 4
jal bubbleSort

# Sorting array3
 la $s2,array3
 lw $s5,length3
la $a0, array3
la $a2, array3
lw $a1, length3
sll $a1, $a1, 2
sub $a1, $a1, 4
jal bubbleSort

j skip

bubbleSort:
    move $t7, $zero
    addi $sp, $sp, -4     # adjust stack to make room for 1 item
    sw $ra, 0($sp)
bubbleSort_outer:
    beq $t7, $a1, stop
    jal firstSort
    add $a0, $a2, $zero
    addi $t7, $t7, 4
    j bubbleSort_outer

stop:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

firstSort:
    addi $sp, $sp, -4      # adjust stack to make room for 1 item
    sw $ra, 0($sp)         # save return address
    add $t4, $zero, $zero  # i = 0
    addi $v0,$v0,1         # started with thinking that will not swap any variable
firstSort_inner:
    beq $t4, $a1, exit     # if i > length, exit
    jal swap               # swap between 2 numbers
    addi $t4, $t4, 4       # i++
    addi $a0, $a0, 4       # move to the next element in the array
    j firstSort_inner

exit:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

swap:
    lw $t0, 0($a0)
    lw $t1, 4($a0)
    slt $t2, $t1, $t0      # if $t1 < $t0
    beq $t2, $zero, noswap
    move $t3, $t0
    sw $t1, 0($a0)
    sw $t3, 4($a0)
    andi $v0,$v0,0
    addi $v0,$v0,0   #if swaping return0
    
noswap:

    jr $ra

skip:
